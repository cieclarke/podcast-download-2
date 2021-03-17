class Episode < ApplicationRecord
    after_find :add

    attr_accessor :file_name

    belongs_to :podcast
    has_one :audio
    validates :url, format: { with: /http[s]?:\/\/.*/ }

    private
    
    def add
        self.file_name = File.join(self.id.to_s + ".mp3")
    end

end
