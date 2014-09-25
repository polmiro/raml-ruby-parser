module Raml
  class Protocol < ValueElement
    ALLOWED_PROTOCOLS = %w(HTTP HTTPS)
    validates :value, :inclusion => { :in => ALLOWED_PROTOCOLS }
  end
end