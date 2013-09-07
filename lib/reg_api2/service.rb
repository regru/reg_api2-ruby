# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API service category
  module Service

    include RegApi2::Builder

    category :service

    # @!method nop(opts = {})
    # @param opts
    # @option opts [Array] services
    # Return list of specified services with its stats if specified.
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

    extend self
  end
end
