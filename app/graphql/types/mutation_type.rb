module Types
  class MutationType < Types::BaseObject
    field :chat_message_create, mutation: Chats::Mutations::CreateMessage
    field :user_sign_up, mutation: Users::Mutations::SignUp
  end
end
