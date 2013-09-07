require 'reg_api2/entity/entity_base'

module RegApi2
  module Entity
    # Represents REG.API user.
    class User < EntityBase
      # @note Required property.
      attr_accessor :user_login
      # @note Required property.
      attr_accessor :user_password
      # @note Required property.
      attr_accessor :user_email
      # @note Required property.
      attr_accessor :user_country_code

      attr_accessor :user_first_name
      attr_accessor :user_last_name
      attr_accessor :user_company
      attr_accessor :user_jabber_id
      attr_accessor :user_icq
      attr_accessor :user_phone
      attr_accessor :user_fax
      attr_accessor :user_addr
      attr_accessor :user_city
      attr_accessor :user_state
      attr_accessor :user_postcode
      attr_accessor :user_wmid
      attr_accessor :user_website

      attr_accessor :user_subsribe
      attr_accessor :user_mailnotify
      attr_accessor :set_me_as_referrer
      attr_accessor :check_only
    end
  end
end
