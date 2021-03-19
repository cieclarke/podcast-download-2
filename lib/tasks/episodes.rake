

desc "updates episodes in DB"

require 'open-uri'
require 'nokogiri'
require_relative '../../config/environment'

namespace :episodes do

  desc 'Update the podcast episodes'
  task :update do
    podcast_service = Services::PodcastService.new
    
    podcasts = podcast_service.all
    podcasts.each do |podcast|
      rss = Nokogiri::XML(URI.open(podcast.url))
      rss.xpath('//item').each do |item|
        
        title = item.xpath('title/text()').to_s
        guid = item.xpath('guid/text()').to_s
        url = item.xpath('enclosure/@url').to_s
        publish_date = item.xpath('pubDate/text()').to_s

        episodes = podcast.episodes.all.where ( {guid: guid}  )
        
        if episodes.count <= 0
          podcast_service.save_episode({ podcast_id: podcast.id, title: title, guid: guid, url: url, publication_date: publish_date })
        end

      end
    end
  end

  desc 'Reset the podcast episodes'
  task :reset do

    delete_count = Episode.delete_all

    podcast_service = Services::PodcastService.new
    
    podcasts = podcast_service.all
    podcasts.each do |podcast|
      rss = Nokogiri::XML(URI.open(podcast.url))
      rss.xpath('//item').each do |item|
        
        title = item.xpath('title/text()').to_s
        guid = item.xpath('guid/text()').to_s
        url = item.xpath('enclosure/@url').to_s
        publish_date = item.xpath('pubDate/text()').to_s

        episodes = podcast.episodes.all.where ( {guid: guid}  )
        
        if episodes.count <= 0
          podcast_service.save_episode({ podcast_id: podcast.id, title: title, guid: guid, url: url, publication_date: publish_date })
        end

      end
    end

  end

  desc 'Download (& maintain) the podcast episodes'
  task :files do
    podcast_service = Services::PodcastService.new
    podcasts = podcast_service.all
    progressbar = ProgressBar.create(total: podcasts.size, format: ' %c/%C %P%%|%B|%e')

    podcasts.each do |podcast|

      current_files = Set.new

      if Dir.exist?(podcast.folder_path)
        current_files = Dir.entries(podcast.folder_path).select { |f| !f.starts_with?('.') }.map { |f| File.join(podcast.folder_path, f)  }.to_set
      else
        FileUtils.mkdir_p File.dirname(podcast.folder_path)
      end
      
      recent_files = podcast.recent_episodes.map { |ep| File.join(podcast.folder_path, ep.file_name) } .to_set

      delete_files = current_files - recent_files
      add_files = recent_files - current_files

      delete_files.to_a.each do |file| File.delete(file) end

        podcast.recent_episodes.delete_if { |episode| !add_files.to_a.include?(File.join(podcast.folder_path, episode.file_name)) } .each do |episode|
          
          episode_filepath = File.join(podcast.folder_path, episode.file_name)
          mp3 = Down.download(episode.url, max_redirects: 3)
          FileUtils.mv(mp3.path, episode_filepath)

        end
        progressbar.increment
      end
      progressbar.finish
  end
  
end