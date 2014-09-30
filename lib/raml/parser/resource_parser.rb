module Raml
  module Parser
    class ResourceParser
      REGEXP = /^\/.*$/

      include ParserHelper

      def initialize(name, hash)
        @name = name
        @hash = hash
      end

      def parse
        attributes = @hash.reduce({}) do |memo, (key, value)|
          case key
          when REGEXP
            memo[:resources] ||= {}
            memo[:resources][key] = self.class.new(key, safe_hash(key, value)).parse
          when "displayName", "description", "type"
            memo[key.to_s.underscore.to_sym] = value
          when "uriParameters"
            memo[:uri_parameters] = parse_uri_parameters(key, value)
          when "baseUriParameters"
            memo[:base_uri_parameters] = parse_base_uri_parameters(key, value)
          when *Method::METHODS
            memo[key.to_sym] = MethodParser.new(key, safe_hash(key, value)).parse
          else
            raise ParserError.new("Unknown option `#{key}` for resource")
          end
          memo
        end
        attributes[:name] = @name
        Resource.new(attributes)
      end
    end
  end
end
