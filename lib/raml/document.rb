module Raml
  class Document < Node
    attribute :title,               Title
    attribute :version,             ApiVersion,                       :required => false
    attribute :media_type,          MediaType,                        :required => false
    attribute :base_uri,            BaseUri,                          :required => false
    attribute :documentation,       Array[Documentation],             :default => []
    attribute :protocols,           Array[Protocol],                  :default => []
    attribute :base_uri_parameters, Hash[String => BaseUriParameter], :default => {}
    attribute :uri_parameters,      Hash[String => UriParameter],     :default => {}
    attribute :schemas,             Hash[String => Schema],           :default => {}
  end
end