class HomeController < ApplicationController
  def index
    @featured_products = Product.order(created_at: :desc).limit(4)
  end
end
