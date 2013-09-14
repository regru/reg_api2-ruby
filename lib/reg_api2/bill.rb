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
    # @option opts [String, Date] :start_date Starting date of the requested period in the ISO format. Mandatory field.
    # @option opts [String, Date] :end_date End date of the requested period in the ISO format. Mandatory field.
    # @option opts [String] :pay_type Payment method. For information about available alternatives refer to the description of response fields.
    # @option opts [Fixnum] :limit Defines the number of invoices to be included in the output at a time. Default value: 100. Maximum value: 1024.
    # @option opts [Fixnum] :offset The offset from the starting point, if the number of invoices exceeds the defined limit.
    # @option opts [FalseClass, TrueClass] :all Show inactive invoices, i.e. invoices for outdated services and invoices cancelled due to impossibility of order execution.
    # @return [Hash(bills)] Bills.
    # @note Accessibility: partners
    # @note Support of invoice lists: yes
    define :get_for_period, required: { start_date: { iso_date: true }, end_date: { iso_date: true } }

    # @!method change_pay_type(opts = {})
    # You can use this function to change payment methods. Some of the methods allow issue of invoices in the defined payment systems, advance payments are made immediately.
    # @note Accessibility: clients
    # @param [Hash] opts
    # @option opts [Fixnum] :bill_id Invoice ID (in case of single invoice request).
    # @option opts [Array(Fixnum)] :bills A list of invoice IDs.
    # @option opts [String] :pay_type New payment type. Mandatory field. Valid values: prepay — advance payment (to be made immediately); WM — WebMoney. With the WMID defined, the invoices are issued to the customer’s WM account; yamoney, ymbill — Yandex.Dengi. To issue an invoice, define ymbill and in advance allow the receipt of invoices from REG.; bank — bank transfer
    # @option opts [String] :currency Currency. Mandatory field. «Yandex.Dengi» allows RUR only, «bank» and «prepay» – RUR and USD, «WebMoney» also allows EUR and UAH.
    # @option opts [Fixnum] :wmid WebMoney ID
    # @note Support of invoice lists: yes
    # @example Example of request
    #    bill.change_pay_type(currency: 'RUR', pay_type: 'prepay', bills: [ 123456 ])
    define :change_pay_type, required: %w[ currency pay_type ]

    extend self
  end
end
