

desc "updates episodes in DB"

require 'open-uri'
require 'nokogiri'
require_relative '../../config/environment'

namespace :episodes do
  task :update do
    podcasts = Podcast.all
    podcasts.each do |podcast|
      rss = Nokogiri::XML(URI.open(podcast.url))
      rss.xpath('//item').each do |item|
        
        title = item.xpath('title/text()').to_s
        guid = item.xpath('guid/text()').to_s
        url = item.xpath('enclosure/@url').to_s
        publish_date = item.xpath('pubDate/text()').to_s

        episodes = Episode.where ( {guid: guid}  )
        
        if episodes.count <= 0
          episode = Episode.new({ podcast_id: podcast.id, title: title, guid: guid, publication_date: publish_date })
          episode.save
        end

        

      end
    end
  end

  task :reset do

    delete_count = Episode.delete_all
    sum_count = 0
    podcasts = Podcast.all
    podcasts.each do |podcast|
      rss = Nokogiri::XML(URI.open(podcast.url))
      rss.xpath('//item').each do |item|
        
        title = item.xpath('title/text()').to_s
        guid = item.xpath('guid/text()').to_s
        url = item.xpath('enclosure/@url').to_s
        publish_date = item.xpath('pubDate/text()').to_s

        episode = Episode.new({ podcast_id: podcast.id, title: title, guid: guid, publication_date: publish_date })
        episode.save
        sum_count += 1

      end
    end

    puts 'deleted: ' + delete_count.to_s + ' inserted: ' + sum_count.to_s
  end

end