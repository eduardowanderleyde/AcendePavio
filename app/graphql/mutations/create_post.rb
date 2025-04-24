module Mutations
  class CreatePost < Mutations::BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(title:, content:)
      post = Post.new(title: title, content: content)
      
      if post.save
        {
          post: post,
          errors: []
        }
      else
        {
          post: nil,
          errors: post.errors.full_messages
        }
      end
    end
  end
end 