# -*- encoding : utf-8 -*-
module RegApi2

  # Common functions
  module Common

    include RegApi2::Builder

    category nil

    #  Nop
    # @param None
    # For testing purposes (do nothing + get the login and identifier of the user logged into the system).
    # @return  [Hash("login", "user_id")]
    define :nop

    #  Nop
    # @param None
    # Similar to the nop function, except for the following  aspects.
    # @note Accessibility: partners
    # @note Access mode: Secure HTTPS only
    # @note Support of service lists: no
    # @return  [Hash("login", "user_id")]
    define :reseller_nop


    #  get_user_id
    # @param None
    # For testing purposes (returns the identifier of the user logged into the system).
    # @return  [Hash("user_id")]
    define :get_user_id

    extend self
  end
end

