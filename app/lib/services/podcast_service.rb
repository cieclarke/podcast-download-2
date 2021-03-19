require_relative '../../../config/environment'


module Services

    class PodcastService

        def initialize()
           
        end     
        
        def new
            Podcast.new
        end
        
        def all
            Podcast.all
        end

        def where(params)
            Podcast.where params
        end

        def podcast(id)
            Podcast.find id 
        end

        def create(p)
            podcast = Podcast.new(p)
            if podcast.save then
                { :podcast => podcast, :valid => true, :errors => [] }
            else
                { :podcast => podcast, :valid => false, :errors => podcast.errors }
            end
            
        end

        def delete(p)
            p.destroy
        end

        def update(id, p)
            podcast = self.podcast(id)
            if podcast.update(p) then
                { :podcast => podcast, :valid => true, :errors => [] }
            else
                { :podcast => podcast, :valid => false, :errors => podcast.errors }
            end
        end

        def save(p)
            Podcast.save(p)
        end

        def folder_path(p)
            base_folder = Rails.configuration.audio['base_folder'].nil? ? '/' : Rails.configuration.audio['base_folder']
            File.join(base_folder, p.artist, p.album)
        end

        def recent_episodes(p)
            p.episodes.sort_by{|episode| episode.publication_date}.reverse.first(p.recent)
        end

    end

end
