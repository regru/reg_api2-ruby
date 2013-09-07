require 'reg_api2/entity/entity_base'

module RegApi2
  module Entity
    class User < EntityBase
      attr_accessor :user_login
      attr_accessor :user_password

    end
  end
end
