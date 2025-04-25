class InstagramPost < ApplicationRecord
  has_one_attached :image
  
  validates :image, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
end 