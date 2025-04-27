class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_has_enough_stock

  def total_price
    product.price * quantity
  end

  private

  def product_has_enough_stock
    if product && quantity > product.total_stock
      errors.add(:quantity, "não pode ser maior que o estoque disponível")
    end
  end
end
