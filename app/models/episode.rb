class Episode < ApplicationRecord

    belongs_to :podcast
    has_one :audio
    validates :url, format: { with: /http[s]?:\/\/.*/ }

end
