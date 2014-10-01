module Raml
  module Parser
    module ParserHelper

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

      def parse_base_uri_parameters(key, value)
        parse_parameters(key, Raml::Nodes::BaseUriParameter, value)
      end

      def parse_uri_parameters(key, value)
        parse_parameters(key, Raml::Nodes::UriParameter, value)
      end

      def parse_query_parameters(key, value)
        parse_parameters(key, Raml::Nodes::QueryParameter, value)
      end

      def parse_form_parameters(key, value)
        parse_parameters(key, Raml::Nodes::FormParameter, value)
      end

      def parse_headers(key, value)
        parse_parameters(key, Raml::Nodes::Header, value)
      end

      def parse_parameters(key, klass, value)
        safe_hash_map(key, value) do |name, v|
          v = underscore_keys(v)
          v = v.merge(:name => name)
          klass.new(v)
        end
      end

      def parse_responses(value)
        safe_hash_map("responses", value) do |name, v|
          v = safe_hash("responses", v)
          ResponseParser.new(v).parse
        end
      end

      def safe_array_map(key, value, &block)
        case value
        when nil
          []
        when Array
          value.map(&block)
        else
          raise ParserError.new("Expected array for key '#{key}'. Got '#{value.class}'")
        end
      end

      def safe_hash_map(key, value, &block)
        safe_hash(key, value).inject({}) do |memo, (k, v)|
          memo[k] = block.call(k, v)
          memo
        end
      end

      def safe_hash(key, value)
        case value
        when nil
          {}
        when Hash
          value
        else
          raise ParserError.new("Expected hash for key '#{key}'. Got '#{value.class}'")
        end
      end

      def safe_string(key, value)
        case value
        when String
          value
        else
          raise ParserError.new("Expected string for key '#{key}'. Got '#{value.class}'")
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