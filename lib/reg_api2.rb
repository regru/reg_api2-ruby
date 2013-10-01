# -*- encoding : utf-8 -*-
require "reg_api2/version"

require "reg_api2/request_contract"
require "reg_api2/result_contract"

require "reg_api2/impl"
require 'reg_api2/builder'

require 'reg_api2/common'
require 'reg_api2/domain'
require 'reg_api2/user'
require 'reg_api2/service'
require 'reg_api2/bill'
require 'reg_api2/folder'
require 'reg_api2/zone'

# # REG.API v2
# @example List of services by specified identifiers
#  RegApi2.service.nop(services: [
#    { dname:"test.ru" },
#    { dname: "test.su", servtype: "srv_hosting_ispmgr" },
#    { service_id: 111111 },
#    { service_id: "22bug22" },
#    { surprise: "surprise.ru" }
#  ])
#
# ## RegApi2 module
#
# Provides r/w settings for API connection:
#
# * {RegApi2.username} - Your user name. `test` by default.
# * {RegApi2.password} - Your password. `test` by default.
# * {RegApi2.io_encoding} - Input/ouput encoding. `utf-8` by default.
# * {RegApi2.lang} - Language of API answers. `en` by default.
# * {RegApi2.ca_cert_path}, {RegApi2.pem} and {RegApi2.pem_password} - optional certification properties. nils by default.
#
# Provides shortcuts for API categories:
#
# * {RegApi2.common} API category implemented as {RegApi2::Common} methods.
# * {RegApi2.domain} API category implemented as {RegApi2::Domain} methods.
# * {RegApi2.user} API category implemented as {RegApi2::User} methods.
# * {RegApi2.service} API category implemented as {RegApi2::Service} methods.
# * {RegApi2.bill} API category implemented as {RegApi2::Bill} methods.
# * {RegApi2.folder} API category implemented as {RegApi2::Folder} methods.
# * {RegApi2.zone} API category implemented as {RegApi2::Zone} methods.
#
# Please read {file:README.md} for API overview.

module RegApi2

  # Shortcut for {RegApi2::Common} methods
  # @return [Module] {RegApi2::Common}
  # @api Shortcuts
  def common; RegApi2::Common; end
  module_function :common

  # Shortcut for {RegApi2::Domain} methods.
  # @return [Module] {RegApi2::Domain} 
  # @api Shortcuts
  def domain; RegApi2::Domain; end
  module_function :domain

  # Shortcut for {RegApi2::User} methods.
  # @return [Module] {RegApi2::User}
  # @api Shortcuts
  def user; RegApi2::User; end
  module_function :user

  # Shortcut for {RegApi2::Service} methods.
  # @return [Module] {RegApi2::Service}
  # @api Shortcuts
  def service; RegApi2::Service; end
  module_function :service

  # Shortcut for {RegApi2::Bill} methods.
  # @return [Module] {RegApi2::Bill}
  # @api Shortcuts
  def bill; RegApi2::Bill; end
  module_function :bill

  # Shortcut for {RegApi2::Folder} methods.
  # @return [Module] {RegApi2::Folder}
  # @api Shortcuts
  def folder; RegApi2::Folder; end
  module_function :folder

  # Shortcut for {RegApi2::Zone} methods.
  # @return [Module] {RegApi2::Zone}
  # @api Shortcuts
  def zone; RegApi2::Zone; end
  module_function :zone

end
