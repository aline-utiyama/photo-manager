class User < ApplicationRecord
  has_secure_password
  validates :user_id, uniqueness: true
  validates :password_digest, presence: true
end
