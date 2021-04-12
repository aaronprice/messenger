module Types
  class MutationType < Types::BaseObject
    field :user_sign_up, mutation: Users::Mutations::SignUp
  end
end
