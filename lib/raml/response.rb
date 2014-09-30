module Raml
  class Response < Node
    attribute :description, String,                 :required => false
    attribute :body,        Body,                   :required => false
    attribute :headers,     Hash[String => Header], :default => {}
  end
end