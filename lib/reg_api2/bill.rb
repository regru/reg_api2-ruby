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
    # @note Accessibility: clients
    # @note Support of invoice lists: yes
    define :get_not_payed

    extend self
  end
end
