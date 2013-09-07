# -*- encoding : utf-8 -*-

require 'reg_api2/entity/user'

module RegApi2
  # REG.API user category
  module User

    include RegApi2::Builder

    category :user

    # @!method nop
    # @param None
    # Accessibility testing.
    # @return [NilClass] nil
    define :nop

    # @!method create(opts = {})
    # @param opts
    # @option opts :user_login Login of the new user in the REG.API system. Allowed symbols: Latin lower-case letters (a-z), digits (0 -9) and the symbols "-" and "_".
    define :create, required: %w[ user_login user_password ]

    extend self
  end
end

