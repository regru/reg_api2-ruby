require 'reg_api2/entity/entity_base'

module RegApi2
  module Entity
    # Represents REG.API user.
    class User < EntityBase
      attr_accessor :user_login
      attr_accessor :user_password
      attr_accessor :user_email
      attr_accessor :user_country_code
    end
  end
end
