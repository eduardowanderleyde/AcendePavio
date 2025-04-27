class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product, quantity = 1)
    cart_item = cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + quantity
    cart_item.save
  end

  def remove_product(product)
    cart_items.find_by(product: product)&.destroy
  end

  def update_quantity(product, quantity)
    cart_item = cart_items.find_by(product: product)
    if cart_item
      if quantity > 0
        cart_item.update(quantity: quantity)
      else
        cart_item.destroy
      end
    end
  end

  def total_items
    cart_items.sum(:quantity)
  end

  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end

  def empty?
    cart_items.empty?
  end
end
