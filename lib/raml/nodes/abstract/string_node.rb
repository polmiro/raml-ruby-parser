module Raml
  module Nodes
    class StringNode < Node
      attribute :value, String

      def to_s
        self.value
      end
    end
  end
end