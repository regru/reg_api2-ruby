# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domains'
require 'reg_api2/clients'

module RegApi2

  def common; RegApi2::Common; end
  module_function :common
  def domains; RegApi2::Domains; end
  module_function :domains
  def clients; RegApi2::Clients; end
  module_function :clients


end
