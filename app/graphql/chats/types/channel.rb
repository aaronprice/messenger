module Chats
  module Types
    class Channel < ::Types::BaseObject

      # == Definitions ==========================================================

      description "A channel"

      # == Attributes ===========================================================
      
      field :id, ID, null: false
      field :name, String, null: false

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================
      
    end
  end
end