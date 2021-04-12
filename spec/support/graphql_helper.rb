module GraphQLHelper
  
  attr_accessor :gql_response

  # The returned results of a GraphQL query
  # @return [data] this is the bulk of the return to test.
  # @return [error] any time a query, mutation, subscription throws and error
  class GQLResponse
    attr_reader :data, :errors

    def initialize(args)
      @data = args['data'] || nil
      @errors = args['errors'] || nil
    end
  end

  # basic query to interact with the GraphQL API.
  # @param [query] required The query string that would be passed to the schema.
  def query(query, variables: {}, context: {})

    converted = variables.deep_transform_keys! {|key| key.to_s.camelize(:lower)} || {}

    res = MessengerSchema.execute(query, variables: converted, context: context, operation_name: nil)
    @gql_response = GQLResponse.new(res.to_h)
  end

  alias_method :mutation, :query
end

RSpec.configure do |config|
  config.include GraphQLHelper, type: :graphql
end