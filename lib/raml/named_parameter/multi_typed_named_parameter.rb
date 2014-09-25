module Raml
  class MultiTypedNamedParameter
    include ActiveModel::Model

    attr_accessor :children

    validates :children, :length => { :minimum => 1 }

    def initialize(name, children, klass)
      @name = name.to_s
      @children = children.map do |child|
        klass.new(child.merge(:name => name))
      end
    end
  end
end
