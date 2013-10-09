# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API service category
  module Service

    include RegApi2::Builder

    category :service

    # @!method nop(opts = {})
    # Return list of specified services with its stats if specified.
    # @param opts Options.
    # @option opts [Array<Hash>] services List of services to be retrieved.
    # @return [Array<Hash>] List of specified services with its stats.
    # @note Accessibility: clients
    # @note Support of service lists: yes
    # @example List of services by specified identifiers
    #  RegApi2.service.nop(services: [
    #    { dname:"test.ru" },
    #    { dname: "test.su", servtype: "srv_hosting_ispmgr" },
    #    { service_id: 111111 },
    #    { service_id: "22bug22" },
    #    { surprise: "surprise.ru" }
    #  ])
    define :nop, field: :services

    # @!method get_prices(opts = {})
    # Get services registration/renewal prices.
    # @param opts Options.
    # @option opts [Boolean] :show_renew_data With this flag enabled the system will return the price of renewal (1/0). Optional field.
    # @option opts [String, Symbol] :currency Identifier of the currency in which the prices will be quoted: rur (default), uah, usd, eur. Optional field.
    # @return [Hash(currency, price_group, show_renew_data, prices)] Prices.
    # @note Accessibility: everyone
    # @note Support of service lists: no
    # @example Get prices.
    #    RegApi2.service.get_prices
    define :get_prices

    # @!method get_servtype_details(opts = {})
    # Use this function to get prices for services and general data.
    # @note To obtain prices for several service types, you can define them in the servtype field delimiting them with commas or include several servtype fields into the request. In this case the field subtype is ignored.
    # @param opts Options.
    # @option opts [String, Symbol] :servtype Type of service: srv_webfwd — web forwarding, srv_parking — domain parking, srv_dns_both — DNS support, srv_hosting_ispmgr — hosting, srv_certificate — domain certificate, srv_voucher — domain voucher, srv_kvm — KVM access.
    # @option opts [String, Symbol] :subtype Service subtype.
    # @option opts [Boolean] :unroll_prices Show prices in expanded form.
    # @return [Array(Hash(commonname, ...))] Service type details.
    # @note Accessibility: everyone
    # @example Get service type details.
    #    RegApi2.service.get_servtype_details servtype: :srv_hosting_ispmgr
    define :get_servtype_details


    # @!method create(opts = {})
    # Use the function to order new services.
    # @param opts Options.
    # @option opts [String] :domain_name Name of the domain, for which the service is ordered.
    # @option opts [String, Symbol] :servtype The type of the ordered service.
    #
    #   | servtype | service type |
    #   | ---------|--------------|
    #   | srv_webfwd | web forwarding |
    #   | srv_parking | domain parking |
    #   | srv_dns_both | DNS support |
    #   | srv_hosting_ispmgr | ISPManager hosting |
    #   | srv_hosting_cpanel | CPanel hosting |
    #   | srv_hosting_plesk | PLesk hosting |
    #   | srv_ssl_certificate | SSL certificate |
    #   | srv_certificate | Domain certificate |
    #   | srv_voucher | Domain voucher |
    #   | srv_vps | VPS server |
    #   | srv_license_isp | ISP Manager license |
    #   | srv_addip | additional IP address |
    #   | srv_disk_space | additional disk space |
    #   | srv_antispam | advanced spam protection |
    #   | srv_dedicated | dedicated server |
    #   | srv_kvm | KVM access |
    #
    # @option opts [Object] :period The period for which the service is ordered, the unit of measurement (year or month) depends on the type of the service being ordered. To learn about the measurement units used for each service, use the {#get_servtype_details} function.
    # @option opts [String] :user_servid Domain ID set by the user. Allowed symbols: digits (from 0 through 9), Latin letters (from a through f). Maximum length: 32 symbols. This ID cannot be generated automatically; if it is not defined upon service ordering, the field will be empty. Optional field.
    # @option opts :point_of_sale See {file:README.md#Common_payment_options common payment parameters}.
    # @option opts :pay_type See {file:README.md#Common_payment_options common payment parameters}.
    # @option opts :ok_if_no_money See See {file:README.md#Common_payment_options common payment parameters}.
    # @option opts :folder_name Defines the name of the folder, to which the services will be added (see {file:README.md#Folder_identification_parameters folder identification parameters}).
    # @option opts :folder_id Defines the name of the folder, to which the services will be added (see {file:README.md#Folder_identification_parameters folder identification parameters}).
    # @option opts [Boolean] :no_new_folder Dont't create non-existing folder; otherwise create if not exists.
    # @option opts [String] :comment An arbitrary text describing the order. Optional field.
    # @option opts [String] :admin_comment A comment for administrators. An arbitrary text describing the order. Optional field.
    # TODO: specific options.
    # @return [Hash(descr, service_id, ...)] Information about ordered service.
    # @note Accessibility: everyone
    # @note Support of service lists: no
    # @see #get_servtype_details
    # @example Create srv_hosting_ispmgr service.
    #    RegApi2.service.create dname: 'qqq.ru', servtype: :srv_hosting_ispmgr, period: 1, plan: 'Host-2-1209'
    define :create, required: %w[ servtype ]

    # @!method delete(opts = {})
    # Removes the service.
    # @param opts Options.
    # @option opts [String, Symbol] :servtype Service type, which is to be removed. These values are supported:
    #
    #   | servtype | service type |
    #   | ---------|--------------|
    #   | srv_hosting_ispmgr | ISPManager hosting |
    #   | srv_hosting_cpanel | CPanel hosting |
    #   | srv_hosting_plesk | PLesk hosting |
    #   | srv_addip | additional IP address |
    #   | srv_antispam | advanced spam protection |
    #   | srv_sitebuilder_plsk | SiteBuilder Plesk |
    #   | srv_vps | VPS server |
    #   | srv_license_isp | ISP Manager license |
    #   | srv_disk_space | additional disk space |
    #   | srv_dedicated | dedicated server |
    #   | srv_kvm | KVM access |
    #
    # @return [NilClass] nil
    # @note Accessibility: clients
    # @note Support of service lists: no
    # @example Removing of `srv_hosting_ispmgr` service.
    #    RegApi2.service.delete domain_name: 'test.ru', servtype: :srv_hosting_ispmgr
    define :delete, required: %w[ servtype ]

    # @!method get_info(opts = {})
    # Use this function to obtain information about all services.
    # @param opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: yes
    define :get_info

    # @!method get_list(opts = {})
    # Use this function to obtain a list of active services.
    # @param opts Options.
    # @option opts [String,Symbol] :servtype Type of service. If nothing is defined, information about all types of services will be returned.
    #
    #    | Type   | Description |
    #    |--------|-------------|
    #    |domain | Domain|
    #    |srv_webfwd | web forwarding|
    #    |srv_parking | domain parking|
    #    |srv_dns_both | DNS support|
    #    |srv_hosting_ispmgr | ISPManager hosting|
    #    |srv_hosting_cpanel | CPanel hosting|
    #    |srv_hosting_plesk | Plesk hosting|
    #    |srv_antispam | Extended spam protection|
    #    |srv_vps | VPS server|
    #    |srv_addip | Additional IP address|
    #    |srv_license_isp | ISPManager license|
    #    |srv_certificate | Domain certificate|
    #    |srv_voucher | Domain voucher |
    #
    # @return [Array<Hash>] List of service of specified `servtype`.
    # @note Accessibility: clients
    # @example Get list of domains.
    #    RegApi2.service.get_list servtype: :domain
    define :get_list, field: :services

    # @!method get_folders(opts = {})
    # Use this function to get the list of folders the service is associated with.
    # @param opts Options.
    define :get_folders

    # @!method get_details(opts = {})
    # Use this function to get detailed information about the service, including contact data for domains.
    # @param opts Options.
    define :get_details

    # @!method service_get_details(opts = {})
    # @deprecated Use {#get_info} instead.
    # You can use this function to obtain general information about the ordered service, as well as additional data about the hosting and web forwarding services. It is an obsolete function. For the major part of service it is advisable to use the {#get_info} function instead.
    # @param opts Options.
    define :service_get_details

    # @!method get_dedicated_server_list(opts = {})
    # Get the dedicated server list.
    # @param opts Options.
    # @return [Array<Hash>] List of dedicated servers. Each item of {RegApi2::SymHash} class contain these fields:
    # 
    #   | Field | Description |
    #   |-------|-------------|
    #   | server_id   | Unique server id
    #   | cpu_content | Processor model
    #   | cpu_count   | Processor count
    #   | cpu_core    | Core count
    #   | ram_content | RAM type
    #   | ram_count   | RAM count
    #   | ram_size    | RAM size
    #   | hdd_content | HDD interface type
    #   | hdd_count   | HDD count
    #   | hdd_size    | HDD disk size
    #   | month_traf  | Traffic, GB per month
    #   | price_retail |   Rent per month
    #
    # @note Accessibility: clients
    # @note Support of service lists: no
    # @example Get list of dedicated servers
    #    RegApi2.service.get_dedicated_server_list
    define :get_dedicated_server_list, field: :server_list

    # @!method update(opts = {})
    # Service configuration.
    # @param opts Options.
    define :update

    # @!method renew(opts = {})
    # Domain or service renewal.
    # @param opts Options.
    define :renew

    # @!method get_bills(opts = {})
    # Use this function to get a list of invoices associated with the defined services.
    # @param opts Options.
    # @return [Hash] List of invoices associated with the defined services.
    #
    #    | Field | Description |
    #    | ----- | ----------- |
    #    | services | A list of requested services. |
    #    | bills | A list of IDs of invoices associated with this service. May be nil. |
    #
    # @note Accessibility: partners
    # @note Support of service lists: yes
    # @example Get invoices and services for `qqq.ru` domain.
    #    RegApi2.service.get_bills dname: "qqq.ru"
    define :get_bills

    # @!method set_autorenew_flag(opts = {})
    # Enables or disables automatic service renewal.
    # @param opts Options.
     # @return [NilClass] nil
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :set_autorenew_flag

    # @!method suspend(opts = {})
    # Use this function to suspend services (for domains – suspend delegation).
    # @param opts Options.
    # @return [NilClass] nil
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :suspend

    # @!method resume(opts = {})
    # Use this function to resume services (for domains – resume domain delegation).
    # @param opts Options.
    # @return [NilClass] nil
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :resume

    # @!method get_depreciated_period(opts = {})
    # Use this function to calculate the number of periods till the service expiration date.
    # @param opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :get_depreciated_period

    # @!method upgrade(opts = {})
    # This function upgrades service subtypes (rate plans). It can be used for changes of rate plans for virtual hosting ("srv_hosting_ispmgr"), VPS servers("srv_vps") and Additional Disk Space for VPS ("srv_disk_space").
    # @param opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :upgrade

    # @!method partcontrol_grant(opts = {})
    # You can use this function to grant a part of service management rights to other users.
    # @param opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :partcontrol_grant

    # @!method partcontrol_revoke(opts = {})
    # Use this function to stop granting service management rights to other.
    # @param opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :partcontrol_revoke

    # @!method resend_mail(opts = {})
    # Resend mail to user.
    # @param opts Options.
    # @option opts [Array] mailtype Email type: `approver_email` — approve ssl certificate order, `certificate_email` — certificate email.
    # @return [Hash(service_id, dname)]
    # @note Accessibility: clients
    # @note Support of service lists: no
        # @example Resend mail.
    #    RegApi2.service.resend_mail servtype: :srv_ssl_certificate
    define :resend_mail

    extend self
  end
end
