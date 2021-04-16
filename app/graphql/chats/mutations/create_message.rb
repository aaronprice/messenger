module Chats
  module Mutations
    class CreateMessage < ::Mutations::BaseMutation
      
      argument :channel_name, String, 'Name of the channel in which to post this message', required: true
      argument :body, String, 'Body of the message', required: false
      argument :image_url, String, 'URL of a GIF', required: false

      field :message, Chats::Types::Message, null: true
      field :errors, [Common::Types::Error], null: true

      def resolve(arguments)
        form = Chats::Forms::CreateMessage.new(arguments, context)
        if form.save
          {
            message: form.message,
            errors: []
          }
        else
          {
            message: nil,
            errors: form.errors
          }
        end
      end
    end
  end
end