module Raml
  module Parser
    module ParserHelper
      def parse_uri_parameters(value)
        safe_hash_map("uriParameters",value) do |name, v|
          UriParameter.new(underscore_keys(v).merge(:name => name))
        end
      end

      def parse_form_parameters(value)
        safe_hash_map("formParameters",value) do |name, v|
          FormParameter.new(underscore_keys(v).merge(:name => name))
        end
      end

      def parse_base_uri_parameters(value)
        safe_hash_map("baseUriParameters", value) do |name, v|
          BaseUriParameter.new(underscore_keys(v).merge(:name => name))
        end
      end

      def parse_responses(value)
        case value
        when nil
          []
        when Hash
          value.inject({}) do |memo, (k, v)|
            code = HttpStatusCode.new(:value => k)
            memo[code] = ResponseParser.new(v).parse
            memo
          end
        else
          raise ParserError.new("Expected hash for '#{key}': '#{value}'")
        end
      end

      def set_yaml_include_path(path)
        YAML.add_domain_type("raml-include,2014", "include") do |type, val|
          new_path = File.expand_path(path, val)
          set_yaml_include_path(new_path)
          file_path = File.join(new_path, val)
          result = YAML.load_file(file_path)
          set_yaml_include_path(path)
          result
        end
      end

      def safe_array_map(key, value, &block)
        case value
        when nil
          []
        when Array
          value.map(&block)
        else
          raise ParserError.new("Expected array for '#{key}': '#{value}'")
        end
      end

      def safe_hash_map(key, value, &block)
        case value
        when nil
          {}
        when Hash
          value.inject({}) do |memo, (k, v)|
            memo[k] = block.call(k, v)
            memo
          end
        else
          raise ParserError.new("Expected hash for '#{key}': '#{value}'")
        end
      end

      def underscore_keys(hash)
        hash.reduce({}) do |memo, (key, value)|
          memo[key.to_s.underscore.to_sym] = value
          memo
        end
      end

    end
  end
end