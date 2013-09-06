# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domains'
require 'reg_api2/clients'

#  REG.API v2
module RegApi2

  # Shortcut for common methods.
  def common; RegApi2::Common; end
  module_function :common
  # Shortcut for domains methods.
  def domains; RegApi2::Domains; end
  module_function :domains
  # Shortcut for clients methods.
  def clients; RegApi2::Clients; end
  module_function :clients


end
