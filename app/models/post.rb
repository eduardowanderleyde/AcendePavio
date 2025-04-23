class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, presence: true
  validates :content, presence: true
end
