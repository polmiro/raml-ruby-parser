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
            memo[key.to_s.underscore.to_sym] = value
          when "headers"
            memo[:headers] = safe_hash_map("headers",value) do |name, v|
              Header.new(underscore_keys(v).merge(:name => name))
            end
          when "protocols"
            memo[:protocols] = safe_array_map(key, value) do |v|
              Protocol.new(:value => v)
            end
          when "queryParameters"
            memo[:headers] = safe_hash_map("queryParameters", value) do |name, v|
              QueryParameter.new(underscore_keys(v).merge(:name => name))
            end
          when "body"
            memo[:body] = BodyParser.new(value).parse
          when "responses"
            memo[:responses] = parse_responses(value)
          else
            raise ParserError.new("Unknown method option `#{key}`")
          end
          memo
        end
        attributes[:type] = @name
        Method.new(attributes)
      end
    end
  end
end
