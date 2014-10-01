module Raml
  module Nodes
    class Node
      include ActiveModel::Model
      include Virtus.model(:strict => true)
    end
  end
end