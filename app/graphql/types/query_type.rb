# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :posts, [Types::PostType], null: false, description: "Returns a list of posts"
    field :post, Types::PostType, null: false, description: "Returns a single post" do
      argument :id, ID, required: true
    end
    field :categories, [Types::CategoryType], null: false, description: "Returns a list of categories"
    field :category, Types::CategoryType, null: false, description: "Returns a single category" do
      argument :id, ID, required: true
    end
    field :tags, [Types::TagType], null: false, description: "Returns a list of tags"
    field :users, [Types::UserType], null: false, description: "Returns a list of users"
    field :user, Types::UserType, null: false, description: "Returns a single user" do
      argument :id, ID, required: true
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    end

    def categories
      Category.all
    end

    def category(id:)
      Category.find(id)
    end

    def tags
      Tag.all
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end
  end
end
