require 'raml/version'

require 'virtus'
require 'active_model'
require 'active_support'
require 'raml/errors'
require 'raml/parseable_element'
require 'raml/value_element'
require 'raml/parser'
require 'raml/parser_helper'
require 'raml/document'
require 'raml/title'
require 'raml/api_version'
require 'raml/media_type'
require 'raml/base_uri'
require 'raml/named_parameter/named_parameter'
require 'raml/named_parameter/multi_typed_named_parameter'
require 'raml/named_parameter/base_uri_parameter'
require 'raml/named_parameter/uri_parameter'
require 'raml/named_parameter/query_parameter'
require 'raml/documentation'
require 'raml/protocol'
require 'raml/schema'

module Raml
  def self.load(raml)
    Raml::Parser.parse(raml)
  end

  def self.load_file(filename)
    file = File.new(filename)
    Raml::Parser.parse(file.read)
  end
end
