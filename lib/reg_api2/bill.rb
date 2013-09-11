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

    extend self
  end
end
