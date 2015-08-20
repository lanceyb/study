#module Abc
  #def included base =nil, &block
    #p "included now"
    #if base.nil?
      #@_included_block = block
      #p "defined @_included_block"
    #else
      #super
    #end
  #end

  #def append_features(base)
    #p "ready to eval block"
    #base.class_eval(&@_included_block) if instance_variable_defined?(:@_included_block)
  #end
#end

#module Foo
  #extend Abc
  #def hello_world
    #p "hello world!"
  #end
#end

#module Def
  #included do
    #p "i am included in Def"
  #end
#end

#module Ghd
  ##extend Abc
  #include Def
#end

require 'active_support/concern'

module Abc
  extend ActiveSupport::Concern
  included { p "i am in included block" }
  included { p "multi call included" }
end

module Def
  include Abc
end
