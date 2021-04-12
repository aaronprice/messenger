require 'graphql/rake_task'
GraphQL::RakeTask.new(schema_name: 'MessengerSchema', directory: 'app/graphql/')
