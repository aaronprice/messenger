module Chats
  module Types
    class Message < ::Types::BaseObject

      # == Definitions ==========================================================

      description "A message"

      # == Attributes ===========================================================
      
      field :id, ID, null: false
      field :body, String, null: true
      field :image_url, String, null: true
      field :created_at, Common::Scalars::Timestamp, null: false

      # == Relationships ========================================================

      field :author, Users::Types::User, null: false
      field :channel, Chats::Types::Channel, null: false

      # == Class Methods ========================================================

      # == Instance Methods =====================================================

      def author
        object.user
      end

      def channel
        object.channel
      end
      
    end
  end
end