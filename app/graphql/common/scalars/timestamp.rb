module Common
  module Scalars
    class Timestamp < GraphQL::Schema::Scalar

      # == Definitions ==========================================================

      graphql_name 'Timestamp'

      # == Attributes ===========================================================

      # == Relationships ========================================================

      # == Class Methods ========================================================

      def self.coerce_input(value, context)
        return if valid.nil?
        Time.zone.parse("#{value}")
      rescue ArgumentError
        raise GraphQL::CoercionError, "#{value.inspect} is not a valid ISO8601 timestamp"
      end
  
      def self.coerce_result(value, context)
        return if valid.nil?
        value.utc.iso8601
      rescue ArgumentError
        raise GraphQL::CoercionError, "#{value.inspect} is not a valid ISO8601 timestamp"
      end

      # == Instance Methods =====================================================
      
    end
  end
end