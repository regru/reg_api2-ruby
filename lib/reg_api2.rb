# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/request_contract/default"
require "reg_api2/result_contract/default"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domains'
require 'reg_api2/clients'
require 'reg_api2/user'
require 'reg_api2/service'

# REG.API v2
# @example List of services by specified identifiers
#  RegApi2.service.nop(services: [
#    { dname:"test.ru" },
#    { dname: "test.su", servtype: "srv_hosting_ispmgr" },
#    { service_id: 111111 },
#    { service_id: "22bug22" },
#    { surprise: "surprise.ru" }
#  ])

module RegApi2

  # Shortcut for {RegApi2::Common} methods
  # @return [Module]
  def common; RegApi2::Common; end
  module_function :common

  # Shortcut for {RegApi2::Domains} methods.
  # @return [Module]
  def domains; RegApi2::Domains; end
  module_function :domains

  # Shortcut for {RegApi2::Clients} methods.
  # @return [Module]
  def clients; RegApi2::Clients; end
  module_function :clients

  # Shortcut for {RegApi2::User} methods.
  # @return [Module]
  def user; RegApi2::User; end
  module_function :user

  # Shortcut for {RegApi2::Service} methods.
  # @return [Module]
  def service; RegApi2::Service; end
  module_function :service

end
