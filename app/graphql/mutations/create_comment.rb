module Mutations
  class CreateComment < Mutations::BaseMutation
    argument :content, String, required: true
    argument :post_id, ID, required: true
    argument :parent_id, ID, required: false

    field :comment, Types::CommentType, null: false
    field :errors, [String], null: false

    def resolve(content:, post_id:, parent_id: nil)
      post = Post.find(post_id)
      parent = parent_id ? Comment.find(parent_id) : nil
      
      comment = Comment.new(
        content: content,
        post: post,
        parent: parent,
        user: context[:current_user]
      )
      
      if comment.save
        {
          comment: comment,
          errors: []
        }
      else
        {
          comment: nil,
          errors: comment.errors.full_messages
        }
      end
    end
  end
end 