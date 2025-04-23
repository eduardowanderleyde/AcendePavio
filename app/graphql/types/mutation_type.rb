# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :create_post, mutation: Mutations::CreatePost
    field :create_comment, mutation: Mutations::CreateComment
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
