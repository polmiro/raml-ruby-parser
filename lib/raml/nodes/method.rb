module Raml
  module Nodes
    class Method < Node
      METHODS = %w(get post patch put delete head options trace connect)

      attribute :type,             String
      attribute :description,      String,                           :required => false
      attribute :headers,          Hash[String => Header],           :default => {}
      attribute :protocols,        Array[Protocol],                  :default => []
      attribute :query_parameters, Hash[String => QueryParameter],   :default => {}
      attribute :body,             Body,                             :required => false
      attribute :responses,        Hash[String => Response], :default => {}

      validates :type, :inclusion => { :in => METHODS }
      validate :validate_http_status_codes

      private

      def validate_http_status_codes
        return true if responses.count == 0

        all_but_last = responses.keys.take(responses.keys.count - 1)
        last = responses.keys.last

        unless all_but_last.all?{ |str| is_int?(str) } && (is_int?(last) || last == "*/*")
          errors.add(:responses, "Invalid http status for response")
        end
      end

      def is_int?(str)
        !!Integer(str)
      rescue ArgumentError, TypeError
        false
      end

    end
  end
end