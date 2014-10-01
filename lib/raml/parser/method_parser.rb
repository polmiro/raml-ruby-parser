module Raml
  module Parser
    class MethodParser
      include ParserHelper

      def initialize(name, hash)
        @name = name
        @hash = hash
      end

      def parse
        attributes = @hash.reduce({}) do |memo, (key, value)|
          case key
          when "description"
            memo[key.to_s.underscore.to_sym] = safe_string(key, value)
          when "headers"
            memo[:headers] = parse_headers(key, value)
          when "protocols"
            memo[:protocols] = safe_array_map(key, value) do |v|
              Nodes::Protocol.new(:value => v)
            end
          when "queryParameters"
            memo[:query_parameters] = parse_query_parameters(key, value)
          when "body"
            memo[:body] = BodyParser.new(safe_hash(key, value)).parse
          when "responses"
            memo[:responses] = parse_responses(value)
          else
            raise ParserError.new("Unknown option `#{key}` for method")
          end
          memo
        end
        attributes[:type] = @name
        Nodes::Method.new(attributes)
      end

    end
  end
end
