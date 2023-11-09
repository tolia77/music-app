class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_many :song_artists, dependent: :destroy
  has_many :artists, through: :song_artists
  validates :title, presence: :true, length: { maximum: 32 }
end
