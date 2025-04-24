module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :status, String, null: false
    field :total, Float, null: false
    field :items, [Types::OrderItemType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def total
      object.total.to_f
    end

    def items
      object.order_items
    end
  end
end 