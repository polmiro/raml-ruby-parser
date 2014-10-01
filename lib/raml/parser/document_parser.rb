module Raml
  module Parser
    class DocumentParser
      include ParserHelper

      def initialize(file_path)
        set_yaml_include_path(File.dirname(file_path))
        @file_path = file_path
        @root = YAML.load_file(file_path)
      end

      def parse
        attrs = { :resources => {}, :schemas => {} }
        @root.each do |key, value|
          case key
            when "title"
              attrs[:title] = Nodes::Title.new(:value => value)
            when "version"
              attrs[:version] = Nodes::ApiVersion.new(:value => value)
            when "mediaType"
              attrs[:media_type] = Nodes::MediaType.new(:value => value)
            when "baseUri"
              attrs[:base_uri] =  Nodes::BaseUri.new(:value => value)
            when "baseUriParameters"
              attrs[:base_uri_parameters] = parse_base_uri_parameters(key, value)
            when "uriParameters"
              attrs[:uri_parameters] = parse_uri_parameters(key, value)
            when "documentation"
              attrs[:documentation] = safe_array_map(key, value) do |v|
                Nodes::Documentation.new(safe_hash(key, v))
              end
            when "protocols"
              attrs[:protocols] = safe_array_map(key, value) do |v|
                Nodes::Protocol.new(:value => v)
              end
            when "schemas"
              safe_array_map(key, value) do |array|
                safe_hash_map(key, array) do |name, path|
                  schemaPath = File.join(File.dirname(@file_path), path)
                  attrs[:schemas][name] = Nodes::Schema.new(:value => schemaPath)
                end
              end
            when "resourceTypes"
              # raise "not implemented"
            when "traits"
              # raise "not implemented"
            when "securitySchemes"
              # raise "not implemented"
            when "securedBy"
              # raise "not implemented"
            when ResourceParser::REGEXP
              attrs[:resources][key] = ResourceParser.new(key, safe_hash(key, value)).parse
            else
              raise ParserError.new("Unknown property `#{key}` for document")
          end
        end
        Nodes::Document.new(attrs)
      end

    end
  end
end