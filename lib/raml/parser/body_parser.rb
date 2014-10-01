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
            memo[:example] = Nodes::Example.new(:value => value)
          when "schema"
            memo[:schema] = Nodes::Schema.new(:value => value)
          else
            raise ParserError.new("Unknown method option `#{key}`")
          end
          memo
        end
        Nodes::Body.new(attributes)
      end

    end
  end
end