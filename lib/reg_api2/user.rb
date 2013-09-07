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
    # @param opts Opts or {RegApi2::Entity::User}
    # @option opts [String] :user_login Login of the new user in the REG.API system. Allowed symbols: Latin lower-case letters (a-z), digits (0 -9) and the symbols "-" and "_".
    # @option opts [String] :user_password Password of the new user.
    # @option opts [String] :user_email User email.
    # @option opts [String] :user_country_code User country code like 'RU'.
    # @return [String] user_id of new user.

    define :create, required: %w[ user_login user_password user_email user_country_code ], field: 'user_id', result: :SingleField

    extend self
  end
end

