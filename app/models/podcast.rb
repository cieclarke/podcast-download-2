class Podcast < ApplicationRecord
    
    has_many :episodes, dependent: :destroy
    validates :artist, presence: true
    validates :album, presence: true
    validates :url, presence: true
    validates :recent, presence: true

    validates :url, format: { with: /http[s]?:\/\/.*/ }
    validates :recent, numericality: { only_integer: true }
    
end
