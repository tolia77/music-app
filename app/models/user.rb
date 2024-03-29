class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  after_create do
    self.role = 0
  end
  enum role: {
    basic: 0,
    moderator: 1,
    admin: 2
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_one :artist, dependent: :destroy
  validates :name, presence: true, length: { maximum: 32 }

  def artist?
    !!self.artist
  end

  def basic?
    self.role == "basic"
  end

  def moderator?
    self.role == "moderator"
  end

  def admin?
    self.role == "admin"
  end
end
