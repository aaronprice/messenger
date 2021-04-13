module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :channels, Chats::Types::Channel.connection_type, null: true, description: 'A list of channels and messages'

    def channels
      Channel.unscoped
    end

  end
end
