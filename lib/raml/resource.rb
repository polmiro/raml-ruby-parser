module Raml
  class Resource < Node
    attribute :name, String
    attribute :display_name, String, :required => false
    attribute :type, String,         :required => false
    attribute :description, String,  :required => false
    attribute :protocols, Array[Protocol],                            :default => []
    attribute :uri_parameters, Hash[String => UriParameter],          :default => {}
    attribute :base_uri_parameters, Hash[String => BaseUriParameter], :default => {}
    attribute :resources, Hash[String => Resource],                   :default => {}
    Method::METHODS.each do |method_name|
      attribute method_name, Method, :required => false
    end

    def initialize(attrs = {})
      if attrs[:display_name].nil?
        attrs[:display_name] = attrs[:name]
      end
      super(attrs)
    end
  end
end