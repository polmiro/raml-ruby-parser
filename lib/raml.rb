require 'raml/version'

require 'virtus'
require 'active_model'
require 'active_support'
require 'raml/errors'
require 'raml/node'
require 'raml/value_element'

require 'raml/parser/parser_helper'
require 'raml/parser/document_parser'
require 'raml/parser/resource_parser'
require 'raml/parser/method_parser'
require 'raml/parser/body_parser'
require 'raml/parser/response_parser'
require 'raml/parser'

require 'raml/title'
require 'raml/api_version'
require 'raml/media_type'
require 'raml/base_uri'
require 'raml/named_parameter/named_parameter'
require 'raml/named_parameter/multi_typed_named_parameter'
require 'raml/named_parameter/base_uri_parameter'
require 'raml/named_parameter/uri_parameter'
require 'raml/named_parameter/query_parameter'
require 'raml/named_parameter/form_parameter'
require 'raml/named_parameter/header'
require 'raml/example'
require 'raml/documentation'
require 'raml/protocol'
require 'raml/schema'
require 'raml/body'
require 'raml/response'
require 'raml/method'
require 'raml/resource'
require 'raml/document'

module Raml
  def self.load(raml)
    Raml::Parser.parse(raml)
  end

  def self.load_file(filename)
    file = File.new(filename)
    Raml::Parser.parse(file.read)
  end
end
