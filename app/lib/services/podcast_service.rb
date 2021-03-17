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
            self.all.where params
        end

        def podcast(id)
            Podcast.find id 
        end

        def save_podcast(p)
            v = Hash.new
            podcast = Podcast.create(p)
            v[:podcast] = podcast
            v[:saved] = podcast.save
            if !v[:saved]
                v[:errors] = podcast.errors
            end
            v
        end

        def save_episode(e)
            v = Hash.new
            episode = Episode.create(e)
            v[:podcast] = episode
            v[:saved] = episode.save
            if !v[:saved]
                v[:errors] = podcast.errors
            end
            v
        end

    end

end
