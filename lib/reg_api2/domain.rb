# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API domain category
  module Domain

    include RegApi2::Builder

    category :domain

    # @!method nop(opts = {})
    # @param [Hash] opts
    # @option opts [String] :dname Domain name to check.
    # For testing purposes. Also, with the help of this function you can check accessibility of a domain and get its ID. For this, pass username+password+dname.
    # @return [NilClass or String] nil or Domain identifier, available only when the domain name is passed in the field domain_name/dname.
    define :nop

    extend self
  end
end
