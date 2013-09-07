# -*- encoding : utf-8 -*-

require 'reg_api2/result_contract/single_field'

module RegApi2

  # REG.API common category
  module Common

    include RegApi2::Builder

    category nil

    # @!method nop
    # @param None
    # For testing purposes (do nothing + get the login and identifier of the user logged into the system).
    # @return [Hash("login", "user_id")]
    define :nop

    # @!method reseller_nop
    # @param None
    # Similar to the nop function, except for the following  aspects.
    # @note Accessibility: partners
    # @note Access mode: Secure HTTPS only
    # @note Support of service lists: no
    # @return [Hash("login", "user_id")]
    define :reseller_nop


    # @!method get_user_id
    # @param None
    # For testing purposes (returns the identifier of the user logged into the system).
    # @return [String] user_id
    define :get_user_id, :result => RegApi2::ResultContract::SingleField, :field => 'user_id'

    # @!method get_service_id(opts = {})
    # @param [Hash] opts The options.
    # @option opts [FixNum] :service_id Service identifier.
    # Gets service/domain identifier
    # @return [String] service_id
    define :get_service_id, :result => RegApi2::ResultContract::SingleField, :field => 'service_id'

    extend self
  end
end

