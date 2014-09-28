module Raml
  class Document
    include ParserHelper

    attr_accessor :title, :version, :media_type, :base_uri, :base_uri_parameters, :uri_parameters, :documentation, :protocols, :secured_by, :security_protocols, :schemas, :traits, :types

    def initialize(file_path)
      parse_root(file_path).each do |key, value|
        case key
          when "title"
            @title = Title.new(:value => value)
          when "version"
            @version = ApiVersion.new(:value => value)
          when "mediaType"
            @media_type = MediaType.new(:value => value)
          when "baseUri"
            @base_uri =  BaseUri.new(:value => value)
          when "baseUriParameters"
            @base_uri_parameters = safe_hash_map(key, value) do |paramName, v|
              BaseUriParameter.new(underscore_keys(v).merge('name' => paramName))
            end
          when "uriParameters"
            @uri_parameters = safe_hash_map(key, value) do |paramName, v|
              UriParameter.new(underscore_keys(v).merge('name' => paramName))
            end
          when "documentation"
            @documentation = safe_array_map(key, value) do |v|
              Documentation.new(v)
            end
          when "protocols"
            @protocols = safe_array_map(key, value) do |v|
              Protocol.new(:value => v)
            end
          when "schemas"
            @schemas = {}
            safe_array_map(key, value) do |array|
              safe_hash_map(key, array) do |schemaName, schemaPath|
                fullSchemaPath = File.join(File.dirname(file_path), schemaPath)
                @schemas[schemaName] = Schema.new(:value => fullSchemaPath)
              end
            end
          when "resourceTypes"
            raise "not implemented"
          when "traits"
            raise "not implemented"
          when "securitySchemes"
            raise "not implemented"
          when "securedBy"
            raise "not implemented"
          when /^\/.*$/ # resource
            raise "not implemented"
          else
            raise ParserError.new("Unknown document option `#{key}`")
        end
      end
    end
  end
end