require_relative '../../../config/environment'


module Services

    class EpisodeService

        def initialize()
           
        end     
        
        def create(e)
            Episode.create(e)
        end
        
        def delete_all
            Episode.delete_all
        end

        def file_name(e)
            File.join(e.id.to_s + ".mp3")
        end
        
    end

end
