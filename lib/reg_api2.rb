# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/contract/default"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domains'
require 'reg_api2/clients'
require 'reg_api2/user'

#  REG.API v2
module RegApi2

  # Shortcut for {RegApi2::Common} methods
  def common; RegApi2::Common; end
  module_function :common

  # Shortcut for {RegApi2::Domains} methods.
  def domains; RegApi2::Domains; end
  module_function :domains

  # Shortcut for {RegApi2::Clients} methods.
  def clients; RegApi2::Clients; end
  module_function :clients

  # Shortcut for {RegApi2::User} methods.
  def user; RegApi2::User; end
  module_function :user

end
