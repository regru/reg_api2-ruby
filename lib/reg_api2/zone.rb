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
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Request records for test.ru and test.com.
    #    RegApi2.zone.get_resource_records domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :get_resource_records

    # @!method update_records(opts = {})
    # You can use this function to add and/or delete several resource records by means of a single request. The order of elements in the transferred array is important. Records can interrelate with each other, and if an error is found in one of the records from the action_list fields, the rest of the records will be ignored.
    # @param [Hash] opts
    # @option opts [Array(Hash)] :action_list A hash array, where every hash provides parameters for creation/deletion of a resource record. The class/type of the created records is defined in the “action” field, allowed values are: add_alias, add_aaaa, add_cname, add_mx, add_ns, add_txt, add_srv, remove_record. The rest of hash fields depend on the “action” value and correspond to the functions described above.
    #                                         For the example given below the structure of action_list will look as follows:
    #                                         ```
    #                                         action_list => [
    #                                             {
    #                                                 action    => 'add_alias',
    #                                                 subdomain => 'www',
    #                                                 ipaddr    => '11.22.33.44'
    #                                             },
    #                                             {
    #                                                 action         => 'add_cname',
    #                                                 subdomain      => '@',
    #                                                 canonical_name => 'www.test.ru'
    #                                             }
    #                                         ]
    #                                         ```
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: partners
    # @example Tie the IP address 11.22.33.44 to the www.test.ru domain and assign the test.ru alias to it.
    #    RegApi2.zone.update_records domain_name: "test.ru", action_list: [
    #      { action: :add_alias, subdomain: "www", ipaddr: "11.22.33.44" },
    #      { action: :add_cname, subdomain: "@", canonical_name: "www.test.ru" }
    #    ]
    define :update_records

    # @!method update_soa(opts = {})
    # You can use this function to change a zone cache TTL.
    # @param [Hash] opts
    # @option opts [Fixnum or String] :ttl Cache TTL of a zone. Valid values: a number for seconds or a number with a suffix (m – for months, w – for weeks, d – for days, h – for hours). Example: 600 (seconds), 5m (months).
    # @option opts [Fixnum or String] :minimum_ttl Cache TTL for negative responses. The format is the same as for the “ttl” field.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @example Set TTL.
    #     RegApi2.zone.update_soa domains: [ { dname: "test.ru" }, { dname: "test.com" } ], ttl: "1d", minimum_ttl: "4h"
    define :update_soa, required: %w[ ttl minimum_ttl ]

    # @!method tune_forwarding(opts = {})
    # Use this function to add resource records required for web forwarding.
    # @param [Hash] opts
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @see #clear_forwarding
    # @example Add resource records required for web forwarding.
    #     RegApi2.zone.tune_forwarding domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :tune_forwarding

    # @!method clear_forwarding(opts = {})
    # Use this function to delete resource records required for web forwarding.
    # @param [Hash] opts
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @see #tune_forwarding
    # @example Delete resource records required for web forwarding.
    #     RegApi2.zone.clear_forwarding domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :clear_forwarding

    # @!method tune_parking(opts = {})
    # Use this function to add resource records required for domain parking.
    # @param [Hash] opts
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @see #clear_parking
    # @example Add resource records required for domain parking.
    #     RegApi2.zone.tune_parking domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :tune_parking

    # @!method clear_parking(opts = {})
    # Use this function to delete resource records required for domain parking.
    # @param [Hash] opts
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @see #tune_parking
    # @example Delete resource records required for domain parking.
    #     RegApi2.zone.clear_parking domains: [ { dname: "test.ru" }, { dname: "test.com" } ]
    define :clear_parking

    # @!method remove_record(opts = {})
    # Use this function to delete resource records.
    # @param [Hash] opts
    # @option opts [String] :subdomain The subdomain for which the resource record will be deleted.
    # @option opts [String or Symbol] :record_type The class/type of the deleted record. Mandatory field.
    # @option opts [Fixnum] :priority Optional field. Default value: 0. Not applicable to the request for removal of an A-record (and similar records).
    # @option opts [String] :content The content of the record. Optional field. If it is not available, all records satisfying the settings of the rest of parameters will be deleted.
    # @return [Hash(domains)] A list of domains with results.
    # @note Support of service lists: yes
    # @note Accessibility: clients
    # @see #tune_parking
    # @example Delete A record with 111.111.111.111 ip from @.
    #     RegApi2.zone.remove_record domains: [ { dname: "test.ru" }, { dname: "test.com" } ], subdomain: '@', content: '111.111.111.111', record_type: :A
    define :remove_record, required: %w[ subdomain record_type ]

    extend self
  end
end
