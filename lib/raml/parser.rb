module Raml
  module Parser
    def self.parse(data)
      @data = YAML.load(data)
      Document.new(@data)
    end
  end
end