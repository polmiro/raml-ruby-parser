module Raml
  class ParseableElement
    include ActiveModel::Model
    include Virtus.model(:strict => true)
  end
end