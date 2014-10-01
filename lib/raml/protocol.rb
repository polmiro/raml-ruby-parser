module Raml
  class Protocol < StringNode
    ALLOWED_PROTOCOLS = %w(HTTP HTTPS)
    validates :value, :inclusion => { :in => ALLOWED_PROTOCOLS }
  end
end