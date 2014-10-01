module Raml
  module Nodes
    class Documentation < Node
      attribute :title,   String
      attribute :content, String
    end
  end
end