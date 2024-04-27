class Artist < ApplicationRecord
  belongs_to :user
  has_many :song_artists, dependent: :destroy
  has_many :songs, through: :song_artists
  has_many :album_artists, dependent: :destroy
  has_many :albums, through: :album_artists
  has_one_attached :avatar do |img|
    img.variant :small, resize_to_limit: [50, 50]
    img.variant :standard, resize_to_limit: [100, 100]
  end
  validate :validate_content_type
  validates :name, presence: true, length: { maximum: 32 }
  validates :description, length: { maximum: 1000 }

  def validate_content_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/png image/jpeg))
      errors.add(:avatar, 'Must be PNG or JPEG')
    end
  end
end
