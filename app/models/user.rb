class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  after_create :create_cart_for_user

  private

  def create_cart_for_user
    Cart.create(user: self) unless self.cart
  end
end
