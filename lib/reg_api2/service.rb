# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API service category
  module Service

    include RegApi2::Builder

    category :service

    # @!method nop
    # @param None
    # For testing purposes (do nothing + get the login and identifier of the user logged into the system).
    # @return [Hash("login", "user_id")]
    define :nop

    extend self
  end
end
