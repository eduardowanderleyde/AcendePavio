module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :user, Types::UserType, null: false
    field :category, Types::CategoryType, null: false
    field :comments, [Types::CommentType], null: false
    field :tags, [Types::TagType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end 