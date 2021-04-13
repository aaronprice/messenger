module Chats
  module Types
    class Image < ::Types::BaseObject

      # == Definitions ==========================================================

      description "An image from Giphy"

      # == Attributes ===========================================================
      
      field :id, ID, null: false
      field :url, String, null: true

      # == Relationships ========================================================

      # == Class Methods ========================================================

      # == Instance Methods =====================================================

      def url
        object.url.to_s
      end
      
    end
  end
end