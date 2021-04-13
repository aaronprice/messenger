module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :channels, Chats::Types::Channel.connection_type, null: true, description: 'A list of channels and messages'
    field :images, [Chats::Types::Image], null: true, description: 'Images from Giphy' do 
      argument :search, String, required: true
    end

    def channels
      Channel.unscoped
    end

    def images(arguments)
      Giphy.search(arguments[:search], { limit: 10 })
    end

  end
end
