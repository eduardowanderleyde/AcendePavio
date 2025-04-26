require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get show" do
    get product_url(products(:one))
    assert_response :success
  end

  test "should filter by category" do
    category = Category.create!(name: "Tops")
    product = Product.create!(name: "Produto Tops", price: 100, stock: 5)
    product.categories << category
    get products_url, params: { category: "Tops" }
    assert_response :success
    assert_match "Produto Tops", @response.body
  end

  test "should filter by min_price" do
    Product.create!(name: "Barato", price: 10, stock: 5)
    caro = Product.create!(name: "Caro", price: 200, stock: 5)
    get products_url, params: { min_price: 100 }
    assert_response :success
    assert_match "Caro", @response.body
    assert_no_match "Barato", @response.body
  end
end
