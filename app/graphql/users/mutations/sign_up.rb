module Users
  module Mutations
    class SignUp < ::Mutations::BaseMutation
      
      argument :name, String, "Name of the user", required: true

      field :user, Users::Types::Me, null: true
      field :errors, [Common::Types::Error], null: true

      def resolve(arguments)
        form = Users::Forms::SignUp.new(arguments, context)
        if form.save
          {
            user: form.user,
            errors: []
          }
        else
          {
            user: nil,
            errors: form.errors
          }
        end
      end
    end
  end
end