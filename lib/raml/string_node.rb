module Raml
  class StringNode < Node
    attribute :value, String

    def to_s
      self.value
    end
  end
end