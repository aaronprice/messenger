module Common
  module Types
    class Error < ::Types::BaseObject
      description "An error from a rails object"

      field :field, String, null: false
      field :messages, [String], null: false
    end
  end
end