class Artist < ApplicationRecord
  belongs_to :user
  has_many :song_artists, dependent: :destroy
  has_many :songs, through: :song_artists
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 1000 }
end
