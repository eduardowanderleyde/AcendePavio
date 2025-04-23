module Mutations
  class SignInUser < Mutations::BaseMutation
    null true

    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_for(email: email, password: password)
      
      if user
        token = user.generate_jwt
        {
          token: token,
          user: user,
          errors: []
        }
      else
        {
          token: nil,
          user: nil,
          errors: ['Invalid email or password']
        }
      end
    end
  end
end 