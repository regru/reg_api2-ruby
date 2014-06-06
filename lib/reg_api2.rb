# -*- encoding : utf-8 -*-
require "reg_api2/version"

require 'reg_api2/net_error'
require 'reg_api2/contract_error'
require 'reg_api2/api_error'

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
require 'reg_api2/hosting'
require 'reg_api2/shop'

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
# * {RegApi2.hosting} API category implemented as {RegApi2::Hosting} methods.
# * {RegApi2.shop} API category implemented as {RegApi2::Shop} methods.
#
# Provides dump hooks:
#
# * {RegApi2.dump_requests} to dump outgoing API request forms.
# * {RegApi2.dump_responses} to dump incoming API responses.
#
# Please read {file:README.md} for API overview.
#
# @example List of services by specified identifiers
#  RegApi2.service.nop(services: [
#    { dname:"test.ru" },
#    { dname: "test.su", servtype: "srv_hosting_ispmgr" },
#    { service_id: 111111 },
#    { service_id: "22bug22" },
#    { surprise: "surprise.ru" }
#  ])
#
# @example Dump incoming API responses to `$stderr`
#    RegApi2.dump_responses :stderr

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

  # Shortcut for {RegApi2::Hosting} methods.
  # @return [Module] {RegApi2::Hosting}
  # @api Shortcuts
  def hosting; RegApi2::Hosting; end
  module_function :hosting

  # Shortcut for {RegApi2::Shop} methods.
  # @return [Module] {RegApi2::Shop}
  # @api Shortcuts
  def shop; RegApi2::Shop; end
  module_function :shop

  class << self
    # @!attribute [rw] username
    # @return [String] User name (`test` by default).
    attr_accessor :username
    # @!attribute [rw] password
    # @return [String] Password (`test` by default).
    attr_accessor :password
    # @!attribute [rw] io_encoding
    # @return [String] IO encoding (`utf-8` by default).
    attr_accessor :io_encoding
    # @!attribute [rw] lang
    # @return [String] Language (`en` by default).
    attr_accessor :lang
    # @!attribute [rw] ca_cert_path
    # @return [String] Path to certification authority certificate (nil by default).
    attr_accessor :ca_cert_path
    # @!attribute [rw] pem
    # @return [String] X.509 certificate (nil by default).
    attr_accessor :pem
    # @!attribute [rw] pem_password
    # @return [String] X.509 certificate password (nil by default).
    attr_accessor :pem_password
  end
end
