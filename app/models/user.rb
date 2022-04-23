class User < ApplicationRecord
  has_secure_password
  has_many :photos

  validates :user_id, uniqueness: true
  validates :password_digest, :user_id, presence: true
end
