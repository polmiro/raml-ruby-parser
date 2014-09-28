module Raml
  class Parser
    include ParserHelper

    def self.parse(path)
      Parser.new(path).parse
    end

    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      attrs = { :resources => {}, :schemas => {} }
      parse_root(@file_path).each do |key, value|
        case key
          when "title"
            attrs[:title] = Title.new(:value => value)
          when "version"
            attrs[:version] = ApiVersion.new(:value => value)
          when "mediaType"
            attrs[:media_type] = MediaType.new(:value => value)
          when "baseUri"
            attrs[:base_uri] =  BaseUri.new(:value => value)
          when "baseUriParameters"
            attrs[:base_uri_parameters] = safe_hash_map(key, value) do |name, v|
              BaseUriParameter.new(underscore_keys(v).merge('name' => name))
            end
          when "uriParameters"
            attrs[:uri_parameters] = safe_hash_map(key, value) do |name, v|
              UriParameter.new(underscore_keys(v).merge('name' => name))
            end
          when "documentation"
            attrs[:documentation] = safe_array_map(key, value) do |v|
              Documentation.new(v)
            end
          when "protocols"
            attrs[:protocols] = safe_array_map(key, value) do |v|
              Protocol.new(:value => v)
            end
          when "schemas"
            # raise "not implemented"
          when "resourceTypes"
            # raise "not implemented"
          when "traits"
            # raise "not implemented"
          when "securitySchemes"
            # raise "not implemented"
          when "securedBy"
            # raise "not implemented"
          when /^\/.*$/ # resource
            attrs[:resources][key] = Resource.new(value.merge(:name => key))
          else
            raise ParserError.new("Unknown document option `#{key}`")
        end
      end

      Document.new(attrs)
    end
  end
end