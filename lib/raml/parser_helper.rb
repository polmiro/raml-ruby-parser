module Raml
  module ParserHelper

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