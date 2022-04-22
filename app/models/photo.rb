class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, :image, presence: true
  validates :title, length: { maximum: 30 }
end
