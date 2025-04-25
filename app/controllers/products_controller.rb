class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all

    # Filtro por categoria
    if params[:category].present?
      category = Category.find_by(name: params[:category])
      @products = @products.joins(:categories).where(categories: { id: category.id }) if category
    end

    # Filtro por preço
    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price].present?
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price].present?

    # Ordenação
    @products = case params[:sort]
                when 'price_asc'
                  @products.order(price: :asc)
                when 'price_desc'
                  @products.order(price: :desc)
                when 'newest'
                  @products.order(created_at: :desc)
                when 'oldest'
                  @products.order(created_at: :asc)
                else
                  @products.order(created_at: :desc)
                end

    # Paginação
    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.joins(:categories)
                             .where(categories: { id: @product.category_ids })
                             .where.not(id: @product.id)
                             .distinct
                             .limit(4)
  end
end
