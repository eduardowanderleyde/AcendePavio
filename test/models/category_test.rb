require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should be valid with name" do
    category = Category.new(name: "Saias")
    assert category.valid?
  end

  test "should require name" do
    category = Category.new(name: nil)
    assert_not category.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
