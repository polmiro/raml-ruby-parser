module Raml
  class Body < Node
    attribute :schema,          Schema,                        :required => false
    attribute :example,         Example,                       :required => false
    attribute :form_parameters, Hash[String => FormParameter], :required => false
  end
end