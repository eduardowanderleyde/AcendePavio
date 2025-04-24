class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_many_attached :images

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Enums para tamanhos e cores
  enum size: {
    PP: 0,
    P: 1,
    M: 2,
    G: 3,
    GG: 4
  }

  # Scopes
  scope :featured, -> { order(created_at: :desc).limit(8) }
  scope :by_category, ->(category_id) { joins(:categories).where(categories: { id: category_id }) if category_id.present? }
  scope :by_price_range, ->(min, max) { 
    where('price >= ?', min) if min.present?
    where('price <= ?', max) if max.present?
  }
  scope :in_stock, -> { where('stock > 0') }
  scope :search, ->(query) { where('name ILIKE ? OR description ILIKE ?', "%#{query}%", "%#{query}%") if query.present? }

  def main_image
    images.first
  end

  def available_sizes
    sizes = []
    sizes << 'PP' if stock_pp.to_i > 0
    sizes << 'P' if stock_p.to_i > 0
    sizes << 'M' if stock_m.to_i > 0
    sizes << 'G' if stock_g.to_i > 0
    sizes << 'GG' if stock_gg.to_i > 0
    sizes
  end

  def total_stock
    stock_pp.to_i + stock_p.to_i + stock_m.to_i + stock_g.to_i + stock_gg.to_i
  end

  def available_for_size?(size)
    case size.upcase
    when 'PP' then stock_pp.to_i > 0
    when 'P' then stock_p.to_i > 0
    when 'M' then stock_m.to_i > 0
    when 'G' then stock_g.to_i > 0
    when 'GG' then stock_gg.to_i > 0
    else false
    end
  end
end
