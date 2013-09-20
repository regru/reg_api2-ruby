# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API service category
  module Service

    include RegApi2::Builder

    category :service

    # @!method nop(opts = {})
    # Return list of specified services with its stats if specified.
    # @param opts
    # @option opts [Array] services
    # @return [Hash("services" => [])]
    # @example List of services by specified identifiers
    #  RegApi2.service.nop(services: [
    #    { dname:"test.ru" },
    #    { dname: "test.su", servtype: "srv_hosting_ispmgr" },
    #    { service_id: 111111 },
    #    { service_id: "22bug22" },
    #    { surprise: "surprise.ru" }
    #  ])
    define :nop

    # @!method get_prices(opts = {})
    # Get services registration/renewal prices.
    # @param opts
    # @option opts [FalseClass, TrueClass] :show_renew_data With this flag enabled the system will return the price of renewal (1/0). Optional field.
    # @option opts [String, Symbol] :currency Identifier of the currency in which the prices will be quoted: rur (default), uah, usd, eur. Optional field.
    # @return [Hash(currency, price_group, show_renew_data, prices)] Prices.
    # @example Get prices.
    #    RegApi2.service.get_prices
    define :get_prices

    extend self
  end
end
