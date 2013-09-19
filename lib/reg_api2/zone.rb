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

    # @!method add_cname(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain assigned an IP address. To assign an IP address to a domain, transfer the “@” value. To assign an IP address to all subdomains, which are not explicitly defined in other records, use the “*” value.
    # @option opts [String] :canonical_name Name of the domain assigned a synonym.
    # Use this function to tie a subdomain to another’s domain name.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Tie the third-level domains mail.test.ru and mail.test.com to mx10.test.ru.
    #    RegApi2.zone.add_cname domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: "mail", canonical_name: "mx10.test.ru"
    define :add_cname, required: { canonical_name: {}, subdomain: {} }

    # @!method add_mx(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain, to which the address is assigned. The default value is “@”, i.e. the main domain.
    # @option opts [Fixnum] :priority Mail server priority: from 0 (highest) through 10 (lowest).
    # @option opts [String or IPAddr] :mail_server Domain name or IP address of the mail server (domain name is more preferable because not all mail servers admit IP addresses).
    # Use this function to define the IP address or domain name of the mail server, which will received email destined to your domain.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Tie the the domains test.ru and test.com to the mail servers mail.test.ru and mail.test.com.
    #    RegApi2.zone.add_mx domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: "@", mail_server: "mail"
    define :add_mx, required: { mail_server: { ipaddr: :optional } }, optional: %w[ subdomain ]

    # @!method add_ns(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain that will be handed over to other DNS servers.
    # @option opts [String] :dns_server Domain name of the DNS-server.
    # @option opts [Fixnum] :record_number Order number of the NS record that determines relative arrangement of NS records for the subdomain.
    # You can use this function to hand over a subdomain to other DNS servers.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Hand over domains tt.test.ru and tt.test.com to the DNS server ns1.test.ru.
    #    RegApi2.zone.add_ns domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: "tt", dns_server: "ns1.test.ru", record_number: 10
    define :add_ns, required: { dns_server: {}, subdomain: {}, record_number: { re: /\d\d?/ } }

    # @!method add_txt(opts = {})
    # @param [Hash] opts
    # @option opts [String] :subdomain Name of the subdomain, about which the record is added.
    # @option opts [String] :text Text of the note. Only ASCII alphanumeric characters are allowed.
    # Add an arbitrary note about the subdomain.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Add notes about the mail.test.ru and mail.test.com domains.
    #    RegApi2.zone.add_txt domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: "mail", text: "testmail"
    define :add_txt, required: { text: {}, subdomain: {} }

    # @!method add_srv(opts = {})
    # @param [Hash] opts
    # @option opts [String] :service The service that will be matched against the defined server. For example, to make the sip.test.ru server handle SIP calls over UDP, you should specify the following string: _sip._udp.
    # @option opts [Fixnum] :priority Record priority.
    # @option opts [Fixnum] :weight The load that the servers can handle. Optional field. Default value: 0.
    # @option opts [String] :target The server used by the service.
    # @option opts [Fixnum] :port The port used by the service.
    # Add service record.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Make the sip.test.ru server handle SIP calls destined to xxx@test.ru and xxx@test.com on port 5060 over UDP.
    #    RegApi2.zone.add_srv domains: [ { dname: "test.ru" }, { dname: "test.com" } ], service: "_sip._udp", priority: 0, port: 5060, target: "sip.test.ru"
    define :add_srv, required: { service: {}, priority: { re: /\A\d+\z/ }, target: {}, port: { re: /\A\d+\z/ } }, optional: { weight: { re: /\A\d+\z/ } }

    # @!method get_resource_records(opts = {})
    # Use this fuction to get zone resource records for each domains.
    # @param [Hash] opts
    # @option opts [Array(Hash(dname))] :domains A list of domains, where domains that allow zone management will have the “success” value in the “result” field. Otherwise the “result” field will include the error code explaining the reason of error.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Request records for test.ru and test.com.
    #    RegApi2.zone.get_resource_records domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :get_resource_records

    extend self
  end
end
