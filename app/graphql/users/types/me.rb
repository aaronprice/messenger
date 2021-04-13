module Users
  module Types
    class Me < ::Types::BaseObject
    
      # == Definitions ==========================================================

      description "The current authenticated user."

      # == Attributes ===========================================================

      field :id, ID, null: false
      field :name, String, null: false
      field :auth_token, String, null: false

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================
    end
  end
end