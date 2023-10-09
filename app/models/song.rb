class Song < ApplicationRecord
  has_many :song_artists, dependent: :destroy
  has_many :artists, through: :song_artists
  validates :title, presence: :true, length: { maximum: 32 }
end
