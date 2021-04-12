module Users
  module Types
    class Me < ::Types::BaseObject
      description "The current authenticated user."

      field :id, ID, null: false
      field :name, String, null: false
      field :auth_token, String, null: false
    end
  end
end