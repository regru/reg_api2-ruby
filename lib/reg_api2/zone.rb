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
    # @example Get domains
    #    RegApi2.zone.nop domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :nop

    # @!method add_alias(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain assigned an IP address. To assign an IP address to a domain, transfer the “@” value. To assign an IP address to all subdomains, which are not explicitly defined in other records, use the “*” value.
    # @option opts [String or IPAddr] :ipaddr IP address assigned to the subdomain.
    # Use this function to tie subdomains to IP addresses.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Assign the IP address 111.111.111.111 to the domains test.ru and test.com.
    #    RegApi2.zone.add_alias domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: '@', ipaddr: IPAddr.new("111.111.111.111")
    # @example Same with ip addresses as strings.
    #    RegApi2.zone.add_alias domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: '@', ipaddr: "111.111.111.111"
    define :add_alias, required: { ipaddr: { ipaddr: true }, subdomain: {} }

    # @!method add_aaaa(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain assigned an IP address. To assign an IP address to a domain, transfer the “@” value. To assign an IP address to all subdomains, which are not explicitly defined in other records, use the “*” value.
    # @option opts [String or IPAddr] :ipaddr The IPv6 address assigned to the subdomain.
    # Use this function to tie subdomains to IPv6 addresses.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Assign the IPv6 address aa11::a111:11aa:aaa1:aa1a to the domains test.ru and test.com.
    #    RegApi2.zone.add_aaaa domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: '@', ipaddr: IPAddr.new("aa11::a111:11aa:aaa1:aa1a")
    # @example Same with ipv6 addresses as strings.
    #    RegApi2.zone.add_aaaa domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: '@', ipaddr: "aa11::a111:11aa:aaa1:aa1a"
    define :add_aaaa, required: { ipaddr: { ipaddr: true }, subdomain: {} }

    extend self
  end
end
