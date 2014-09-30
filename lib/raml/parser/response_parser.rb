module Raml
  module Parser
    class ResponseParser
      include ParserHelper

      def initialize(hash)
        @hash = hash
      end

      def parse
        attributes = @hash.reduce({}) do |memo, (key, value)|
          case key
          when "description"
            memo[key.to_s.underscore.to_sym] = value
          when "body"
            memo[:body] = BodyParser.new(value).parse
          when "headers"
            memo[:headers] = parse_headers(value)
          else
            raise ParserError.new("Unknown method option for response `#{key}`")
          end
          memo
        end
        Response.new(attributes)
      end
    end
  end
end
