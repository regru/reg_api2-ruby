# -*- encoding : utf-8 -*-
module RegApi2
  # Internal DSL Builder. Provides metamethods.
  module Builder

    # Extends module by metamethods `category` and `define`.
    def self.included(mod)
      mod.module_eval do

        class << self
          # @!method Sets method category
          # @param category [String or NilClass] Category of methods
          # @see define 
          def category category
            @cat = category
          end

          # @!method Defines API method.
          # @param name Name of specified method.
          def define name, defopts = {} 
            define_method name do |opts = {}|
              RegApi2.make_action(@cat, name, defopts, opts)
            end
          end
        end
      end
    end
  end
end
