# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/request_contract/default"
require "reg_api2/result_contract/default"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domain'
require 'reg_api2/clients'
require 'reg_api2/user'
require 'reg_api2/service'
require 'reg_api2/bill'
require 'reg_api2/folder'
require 'reg_api2/zone'

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
  # @return [Module] {RegApi2::Common}
  def common; RegApi2::Common; end
  module_function :common

  # Shortcut for {RegApi2::Domain} methods.
  # @return [Module] {RegApi2::Domain} 
  def domain; RegApi2::Domain; end
  module_function :domain

  # Shortcut for {RegApi2::Clients} methods.
  # @return [Module] {RegApi2::Clients}
  def clients; RegApi2::Clients; end
  module_function :clients

  # Shortcut for {RegApi2::User} methods.
  # @return [Module] {RegApi2::User}
  def user; RegApi2::User; end
  module_function :user

  # Shortcut for {RegApi2::Service} methods.
  # @return [Module] {RegApi2::Service}
  def service; RegApi2::Service; end
  module_function :service

  # Shortcut for {RegApi2::Bill} methods.
  # @return [Module] {RegApi2::Bill}
  def bill; RegApi2::Bill; end
  module_function :bill

  # Shortcut for {RegApi2::Folder} methods.
  # @return [Module] {RegApi2::Folder}
  def folder; RegApi2::Folder; end
  module_function :folder

  # Shortcut for {RegApi2::Zone} methods.
  # @return [Module] {RegApi2::Zone}
  def zone; RegApi2::Zone; end
  module_function :zone

end
