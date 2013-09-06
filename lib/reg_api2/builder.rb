# -*- encoding : utf-8 -*-
module RegApi2
  module Builder

    def self.included(mod)
      mod.module_eval do

        class << self
          def category category
            @cat = category
          end

          def define symbol
            define_method symbol do |opts = {}|
              RegApi2.make_action(@cat, symbol, opts)
            end
          end
        end
      end
    end
  end
end
