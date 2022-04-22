class User < ApplicationRecord
  has_secure_password
  has_many :photos

  validates :user_id, uniqueness: true
  validates :password_digest, presence: true
end
