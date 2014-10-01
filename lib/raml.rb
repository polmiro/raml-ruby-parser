require 'virtus'
require 'active_model'
require 'active_support'
require 'raml/errors'
require 'raml/version'
require 'raml/parser'
require 'raml/errors'
require 'raml/nodes'

module Raml
  def self.load(raml)
    Raml::Parser.parse(raml)
  end

  def self.load_file(filename)
    file = File.new(filename)
    Raml::Parser.parse(file.read)
  end
end
