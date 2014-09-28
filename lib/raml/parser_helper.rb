module Raml
  module ParserHelper
    def parse_root(file_path)
      set_yaml_include_path(File.dirname(file_path))
      YAML.load_file(file_path)
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