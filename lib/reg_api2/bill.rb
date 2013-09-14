# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API bill category
  module Bill

    include RegApi2::Builder

    category :bill

    # @!method nop(opts = {})
    # @param [Hash] opts
    # @option opts [String] :bill_id Invoice number in case of a single-invoice request.
    # @option opts [Array] :bills A list if invoice numbers.
    # For testing purposes.
    # @return [NilClass or Hash(bills)] nil or bills.
    # @note Support of invoice lists: yes
    # @example Get single bill
    #    RegApi2.bill.nop bill_id: 12345
    # @example Get bills
    #    RegApi2.bill.nop bills: ["12345","12346"]
    define :nop

    # @!method get_not_payed(opts = {})
    # Use this function to obtain a list of unpaid invoices.
    # @param [Hash] opts
    # @option opts [Fixnum] :limit Defines the number of invoices to be included in the output at a time. Default value: 100. Maximum value: 1024.
    # @option opts [Fixnum] :offset The offset from the starting point, if the number of invoices exceeds the defined limit.
    # @return [Hash(bills)] Bills.
    # @note Accessibility: clients
    # @note Support of invoice lists: yes
    define :get_not_payed

    # @!method get_for_period(opts = {})
    # Use this function to obtain a list of invoices for the defined period.
    # @param [Hash] opts
    # @option opts [String] :start_date Starting date of the requested period in the ISO format. Mandatory field.
    # @option opts [String] :end_date End date of the requested period in the ISO format. Mandatory field.
    # @option opts [String] :pay_type Payment method. For information about available alternatives refer to the description of response fields.
    # @option opts [Fixnum] :limit Defines the number of invoices to be included in the output at a time. Default value: 100. Maximum value: 1024.
    # @option opts [Fixnum] :offset The offset from the starting point, if the number of invoices exceeds the defined limit.
    # @option opts [FalseClass, TrueClass] :all Show inactive invoices, i.e. invoices for outdated services and invoices cancelled due to impossibility of order execution.
    # @return [Hash(bills)] Bills.
    # @note Accessibility: partners
    # @note Support of invoice lists: yes
    define :get_for_period, required: %w[ start_date end_date ]

    extend self
  end
end
