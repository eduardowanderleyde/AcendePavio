class ProductsController < ApplicationController
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

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
    @products = @products.order(created_at: :desc).page(params[:page]).per(24)
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.joins(:categories)
                             .where(categories: { id: @product.category_ids })
                             .where.not(id: @product.id)
                             .distinct
                             .limit(4)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Produto criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Produto atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Produto excluído com sucesso.'
  end

  private

  def authorize_admin
    unless current_user && current_user.email == 'ewsa@cin.ufpe.br'
      redirect_to root_path, alert: 'Acesso não autorizado.'
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, images: [], category_ids: [])
  end
end
