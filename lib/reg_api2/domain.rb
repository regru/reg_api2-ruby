# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API domain category
  module Domain

    include RegApi2::Builder

    category :domain

    # @!method nop
    # @param None
    # Accessibility testing.
    # @return [NilClass] nil
    define :nop

    extend self
  end
end
