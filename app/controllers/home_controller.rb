class HomeController < ApplicationController
  def index
    @featured_products = Product.order(created_at: :desc).limit(4)
    @instagram_posts = InstagramService.get_recent_posts
  end
end
