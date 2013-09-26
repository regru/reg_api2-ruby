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
# ## Service identification parameters
# This group of parameters serves for identification of specific pre-ordered services.
#
# Services can be identified by:
#
# * service ID (both domains and services),
# * domain name (domains only),
# * domain name and service type (services only),
# * ID of a parent service, service type or subtype (services only).
#
# Identification by numeric service identifiers is the most reliable and quick method. For this reason, we recommend that you save and store domain/service IDs on your side and use them for service identification.
#
# ## Common payment options
# 
# * point_of_sale
#   * An arbitrary string that identifies a system/web site used by the customer for placing an order for a domain. Optional field. Example: «regpanel.ru».
# * pay_type
#   * Payment option. Currently available payment options: (WM, bank, pbank, prepay, yamoney, rapida, robox, paymer, cash, chronopay).
#   * Default value: prepay. Please note that automatic payments can be done only if the selected payment method is «prepay» and you have enough funds in your account. Otherwise, your order will be marked as unpaid and you will have to arrange the payment manually from your profile page.
# * ok_if_no_money
#   * Enable to create bill when not enough funds to complete the operation. In this case requested operation is stored in the system, however it will be processed after submitting "change payment method" request via web interface. Return error if this flag not set and not enough funds to complete the operation.
module RegApi2

  # Shortcut for {RegApi2::Common} methods
  # @return [Module] {RegApi2::Common}
  def common; RegApi2::Common; end
  module_function :common

  # Shortcut for {RegApi2::Domain} methods.
  # @return [Module] {RegApi2::Domain} 
  def domain; RegApi2::Domain; end
  module_function :domain

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
