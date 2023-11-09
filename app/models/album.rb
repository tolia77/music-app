class Album < ApplicationRecord
  has_many :album_artists, dependent: :destroy
  has_many :artists, through: :album_artists
  has_many :songs
  validates :title, length: { maximum: 64 }
end
