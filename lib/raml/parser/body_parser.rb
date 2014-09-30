module Raml
  module Parser
    class BodyParser
      include ParserHelper

      def initialize(hash)
        @hash = hash
      end

      def parse
        attributes = @hash.reduce({}) do |memo, (key, value)|
          case key
          when "formParameters"
            memo[:form_parameters] = parse_form_parameters(key, value)
          when "example"
            memo[:example] = Example.new(:value => value)
          when "schema"
            memo[:schema] = Schema.new(:value => value)
          else
            raise ParserError.new("Unknown method option `#{key}`")
          end
          memo
        end
        Body.new(attributes)
      end

    end
  end
end