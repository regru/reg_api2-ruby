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
    # @option opts [Boolean] :show_renew_data With this flag enabled the system will return the price of renewal (1/0). Optional field.
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
    # @option opts [Boolean] :unroll_prices Show prices in expanded form.
    # @return [Array(Hash(commonname, ...))] Service type details.
    # @example Get service type details.
    #    RegApi2.service.get_servtype_details servtype: :srv_hosting_ispmgr
    define :get_servtype_details


    # @!method create(opts = {})
    # Use the function to order new services.
    # `servtype` values are supported:
    #
    # | servtype | service type |
    # | ---------|--------------|
    # | srv_webfwd | web forwarding |
    # | srv_parking | domain parking |
    # | srv_dns_both | DNS support |
    # | srv_hosting_ispmgr | ISPManager hosting |
    # | srv_hosting_cpanel | CPanel hosting |
    # | srv_hosting_plesk | PLesk hosting |
    # | srv_ssl_certificate | SSL certificate |
    # | srv_certificate | Domain certificate |
    # | srv_voucher | Domain voucher |
    # | srv_vps | VPS server |
    # | srv_license_isp | ISP Manager license |
    # | srv_addip | additional IP address |
    # | srv_disk_space | additional disk space |
    # | srv_antispam | advanced spam protection |
    # | srv_dedicated | dedicated server |
    # | srv_kvm | KVM access |
    #
    # Common payment options are allowed.
    # folder_name or folder_id are allowed.
    # @option opts [String] :domain_name Name of the domain, for which the service is ordered.
    # @option opts [String, Symbol] :servtype The type of the ordered service.
    # @option opts [Object] :period The period for which the service is ordered, the unit of measurement (year or month) depends on the type of the service being ordered. To learn about the measurement units used for each service, use the {#get_servtype_details} function.
    # @option opts [String] :user_servid Domain ID set by the user. Allowed symbols: digits (from 0 through 9), Latin letters (from a through f). Maximum length: 32 symbols. This ID cannot be generated automatically; if it is not defined upon service ordering, the field will be empty. Optional field.
    # @option opts :point_of_sale See common payment parameters in {file:README.md}.
    # @option opts :pay_type See common payment parameters in {file:README.md}.
    # @option opts :ok_if_no_money See common payment parameters in {file:README.md}.
    # @option opts :folder_name Defines the name of the folder, to which the services will be added (see the list of common folder identification parameters in {file:README.md}).
    # @option opts :folder_id Defines the name of the folder, to which the services will be added (see the list of common folder identification parameters in {file:README.md}).
    # @option opts [Boolean] :no_new_folder Dont't create non-existing folder; otherwise create if not exists.
    # @option opts [String] :comment An arbitrary text describing the order. Optional field.
    # @option opts [String] :admin_comment A comment for administrators. An arbitrary text describing the order. Optional field.
    # TODO: specific options.
    # @return [Hash(descr, service_id, ...)] Information about ordered service.
    # @see #get_servtype_details
    # @example Create srv_hosting_ispmgr service.
    #    RegApi2.service.create dname: 'qqq.ru', servtype: :srv_hosting_ispmgr, period: 1, plan: 'Host-2-1209'
    define :create, required: %w[ servtype ]

    define :delete, required: %w[ servtype ]

    define :get_info

    define :get_list

    define :get_folders

    define :get_details

    define :service_get_details

    define :get_dedicated_server_list

    define :update

    define :renew

    define :get_bills

    define :set_autorenew_flag

    define :suspend

    define :resume

    define :get_depreciated_period

    define :upgrade

    define :partcontrol_grant

    define :partcontrol_revoke

    define :resend_mail

    

    extend self
  end
end
