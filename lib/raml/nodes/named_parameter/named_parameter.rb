module Raml
  module Nodes
    class NamedParameter < Node
      TYPES = %w(string number integer date boolean file)

      attribute  :name, String
      attribute  :display_name, String, :required => false
      attribute  :description, String,  :required => false
      attribute  :type, String,         :required => false, :default => "string"
      attribute  :enum, Array[String],  :required => false
      attribute  :pattern, String,      :required => false
      attribute  :min_length, Integer,  :required => false
      attribute  :max_length, Integer,  :required => false
      attribute  :minimum, Integer,     :required => false
      attribute  :maximum, Integer,     :required => false
      attribute  :example, String,      :required => false
      attribute  :repeat, Boolean,      :required => false, :default => false
      attribute  :required, Boolean,    :required => false, :default => false
      attribute  :default, String,      :required => false

      validates :type,                    :inclusion => { :in => TYPES }
      validate  :validate_enum_nil,       :unless => :string?
      validate  :validate_min_length_nil, :unless => :string?
      validate  :validate_max_length_nil, :unless => :string?
      validate  :validate_minimum_nil,    :unless => :number?
      validate  :validate_maximum_nil,    :unless => :number?

      #
      # Defines type checker methods: e.g: parameter.string?
      #
      TYPES.each do |name|
        define_method "#{name}?" do
          self.type == name
        end
      end

      private

      def validate_enum_nil
        if self.enum.present?
          errors.add(:enum, "enum can only be used with in parameters of type 'string'")
        end
      end

      def validate_min_length_nil
        if self.min_length.present?
          errors.add(:min_length, "minLength can only be used with in parameters of type 'string'")
        end
      end

      def validate_max_length_nil
        if self.max_length.present?
          errors.add(:max_length, "maxLength can only be used with in parameters of type 'string'")
        end
      end

      def validate_minimum_nil
        if self.minimum.present?
          errors.add(:minimum, "minimum can only be used with in parameters of type 'number'")
        end
      end

      def validate_maximum_nil
        if self.maximum.present?
          errors.add(:maximum, "maximum can only be used with in parameters of type 'number'")
        end
      end

    end
  end
end
