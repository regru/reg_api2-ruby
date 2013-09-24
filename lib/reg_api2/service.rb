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

    # @!method get_servtype_details(opts = {})
    # Use this function to get prices for services and general data.
    # @note To obtain prices for several service types, you can define them in the servtype field delimiting them with commas or include several servtype fields into the request. In this case the field subtype is ignored.
    # @param opts
    # @option opts [String, Symbol] :servtype Type of service: srv_webfwd — web forwarding, srv_parking — domain parking, srv_dns_both — DNS support, srv_hosting_ispmgr — hosting, srv_certificate — domain certificate, srv_voucher — domain voucher, srv_kvm — KVM access.
    # @option opts [String, Symbol] :subtype Service subtype.
    # @option opts [FalseClass, TrueClass] :unroll_prices Show prices in expanded form.
    # @return [Array(Hash(commonname, ...))] Service type details.
    # @example Get service type details.
    #    RegApi2.service.get_servtype_details servtype: :srv_hosting_ispmgr
    define :get_servtype_details

    extend self
  end
end
