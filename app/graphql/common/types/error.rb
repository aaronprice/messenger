module Common
  module Types
    class Error < ::Types::BaseObject

      # == Definitions ==========================================================

      description "An error from a rails object"

      # == Attributes ===========================================================

      field :attribute, String, null: false
      field :message, String, null: false

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================
    end
  end
end