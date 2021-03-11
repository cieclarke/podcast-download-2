require_relative '../../../config/environment'


module Services

    class PodcastService

        def initialize()
           
        end        
        
        def all
            Podcast.all
        end

        def by_id(id)
            res = self.all.where ( {id: id}  )
            if res.count > 0
                res[0]
            else
                nil
            end
        end

        def by_artist(artist)
            self.all.where ( {artist: artist}  )
        end

        def by_album(album)
            self.all.where ( {album: album}  )
        end

        def recent_episodes(podcast)
            podcast.episodes.sort_by{|episode| episode.publication_date}.reverse.first(podcast.recent)
        end

    end

end
