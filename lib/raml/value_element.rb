module Raml
  class ValueElement < ParseableElement
    attribute :value, String

    def to_s
      self.value
    end
  end
end