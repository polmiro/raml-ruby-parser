module Raml
  module Parser
    def self.parse(path)
      Document.new(path)
    end
  end
end