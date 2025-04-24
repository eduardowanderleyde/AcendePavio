module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String
    field :price, Float, null: false
    field :stock, Integer, null: false
    field :category, Types::CategoryType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def price
      object.price.to_f
    end
  end
end 