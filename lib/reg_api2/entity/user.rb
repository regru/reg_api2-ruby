require 'reg_api2/entity/entity_base'

module RegApi2
  module Entity
    # Represents REG.API user.
    class User < EntityBase
      attr_accessor :user_login
      attr_accessor :user_password
      attr_accessor :user_email
      attr_accessor :user_country_code

      %w[
        user_first_name
        user_last_name
        user_company
        user_jabber_id
        user_icq
        user_phone
        user_fax
        user_addr
        user_city
        user_state
        user_postcode
        user_wmid
        user_website

        user_subsribe
        user_mailnotify
        set_me_as_referrer
        check_only
      ].each { |n| attr_accessor n.to_sym }
    end
  end
end
