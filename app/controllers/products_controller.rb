class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Filtro por categorias
    if params[:categories].present?
      @products = @products.joins(:categories).where(categories: { id: params[:categories] })
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
                else
                  @products.order(created_at: :desc)
                end

    # Paginação (assumindo que você está usando kaminari)
    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    @related_products = @product.categories.first&.products&.where.not(id: @product.id)&.limit(4) || Product.none
  end
end
