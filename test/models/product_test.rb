require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(name: "Tops")
    @product = Product.new(name: "Camiseta Legal", price: 99.9, stock: 10)
    @product.categories << @category
  end

  test "should be valid with valid attributes" do
    assert @product.valid?
  end

  test "should require name" do
    @product.name = nil
    assert_not @product.valid?
  end

  test "should require price" do
    @product.price = nil
    assert_not @product.valid?
  end

  test "should require stock" do
    @product.stock = nil
    assert_not @product.valid?
  end

  test "should have categories" do
    assert @product.categories.any?
  end

  test "main_image should return first image or nil" do
    assert_nil @product.main_image
  end

  # test "the truth" do
  #   assert true
  # end
end
