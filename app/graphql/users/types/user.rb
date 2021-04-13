module Users
  module Types
    class User < ::Types::BaseObject
    
      # == Definitions ==========================================================

      description "Any user except the authenticated user"

      # == Attributes ===========================================================

      field :id, ID, null: false
      field :name, String, null: false

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================
    end
  end
end