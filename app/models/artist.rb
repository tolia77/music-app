class Artist < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 1000 }
end
