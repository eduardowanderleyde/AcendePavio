class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_product, only: [:add, :remove, :update]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add
    quantity = params[:quantity].to_i || 1
    if @cart.add_product(@product, quantity)
      redirect_to cart_path, notice: 'Produto adicionado ao carrinho com sucesso!'
    else
      redirect_to product_path(@product), alert: 'Não foi possível adicionar o produto ao carrinho.'
    end
  end

  def remove
    if @cart.remove_product(@product)
      redirect_to cart_path, notice: 'Produto removido do carrinho com sucesso!'
    else
      redirect_to cart_path, alert: 'Não foi possível remover o produto do carrinho.'
    end
  end

  def update
    quantity = params[:quantity].to_i
    if @cart.update_quantity(@product, quantity)
      redirect_to cart_path, notice: 'Quantidade atualizada com sucesso!'
    else
      redirect_to cart_path, alert: 'Não foi possível atualizar a quantidade.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
