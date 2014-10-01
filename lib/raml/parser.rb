require_relative 'parser/parser_helper'
require_relative 'parser/document_parser'
require_relative 'parser/resource_parser'
require_relative 'parser/body_parser'
require_relative 'parser/method_parser'
require_relative 'parser/response_parser'
require_relative 'parser'

module Raml
  module Parser
    include ParserHelper

    def self.parse(file_path)
      DocumentParser.new(file_path).parse
    end
  end
end