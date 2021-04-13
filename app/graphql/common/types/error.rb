module Common
  module Types
    class Error < ::Types::BaseObject
      
      # == Definitions ==========================================================

      description "An error from a rails object"

      # == Attributes ===========================================================

      field :field, String, null: false
      field :messages, [String], null: false

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================
    end
  end
end