class Podcast < ApplicationRecord
    after_find :add

    attr_accessor :recent_episodes, :folder_path

    has_many :episodes
    validates :artist, presence: true
    validates :album, presence: true
    validates :url, presence: true
    validates :recent, presence: true

    validates :url, format: { with: /http[s]?:\/\/.*/ }
    validates :recent, numericality: { only_integer: true }

    private
    
    def add
        self.recent_episodes = self.episodes.sort_by{|episode| episode.publication_date}.reverse.first(self.recent)

        base_folder = Rails.configuration.audio['base_folder'].nil? ? '/' : Rails.configuration.audio['base_folder']
        self.folder_path = File.join(base_folder, self.artist, self.album)
    end
end
