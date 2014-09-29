module Raml
  class Method < Node
    METHODS = %w(get post patch put delete head options trace connect)

    attribute :type,             String
    attribute :description,      String,                           :required => false
    attribute :headers,          Hash[String => Header],           :default => {}
    attribute :protocols,        Array[Protocol],                  :default => []
    attribute :query_parameters, Hash[String => QueryParameter],   :default => {}
    attribute :body,             Body,                             :required => false
    attribute :responses,        Hash[HttpStatusCode => Response], :default => {}

    validates :type, :inclusion => { :in => METHODS }
  end
end