module Raml
  module Parser
    include ParserHelper

    def self.parse(file_path)
      DocumentParser.new(file_path).parse
    end
  end
end