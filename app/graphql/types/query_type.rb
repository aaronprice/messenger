module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # == Definitions ==========================================================

    # == Attributes ===========================================================
    
    field :channels, Chats::Types::Channel.connection_type, null: true, description: 'A paginated list of channels and messages'
    field :images, [Chats::Types::Image], null: true, description: 'Images from Giphy' do 
      argument :search, String, required: true
    end
    field :users, Users::Types::User.connection_type, null: true, description: 'A paginated list of all users'

    # == Relationships ========================================================

    # == Class Methods ========================================================

    # == Instance Methods =====================================================

    def channels
      Channel.unscoped
    end

    def images(arguments)
      Giphy.search(arguments[:search], { limit: 10 })
    end

    def users
      User.unscoped
    end

  end
end
