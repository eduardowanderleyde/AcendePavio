require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should show categories and products" do
    Category.create!(name: "Tops")
    Product.create!(name: "Produto Home", price: 50, stock: 2)
    get root_url
    assert_match "Tops", @response.body
    assert_match "Produto Home", @response.body
  end
end
