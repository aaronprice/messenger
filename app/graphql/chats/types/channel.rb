module Chats
  module Types
    class Channel < ::Types::BaseObject

      # == Definitions ==========================================================

      description "A channel"

      # == Attributes ===========================================================
      
      field :id, ID, null: false
      field :name, String, null: false
      field :messages, Chats::Types::Message.connection_type, null: true

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================

      def messages
        object.messages
      end
      
    end
  end
end