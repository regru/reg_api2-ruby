# -*- encoding : utf-8 -*-
module RegApi2
  module User

    include RegApi2::Builder

    category :user

    # @!method nop
    # @param None
    # Accessibility testing.
    # @return [NilClass] nil
    define :nop

    extend self
  end
end

