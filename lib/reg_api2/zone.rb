# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API zone category
  module Zone

    include RegApi2::Builder

    category :zone

    # @!method nop(opts = {})
    # @param [Hash] opts
    # @option opts [Array(dname:String)] :domains A list if domains.
    # This function serves for testing purposes. You can check if you can manage DNS zones of domains. DNS zone management is possible only with domains associated with REG.RU DNS servers.
    # @return [Hash(domains)] A list of domains. Domains that allow DNS zone management will have the “success” value in the “result” field, otherwise the “result” field will feature an error code explaining the error reason.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Get domaina
    #    RegApi2.zone.nop domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :nop

    extend self
  end
end
