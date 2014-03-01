# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API domain category
  module Domain

    include RegApi2::Builder

    category :domain

    # @!method nop(opts = {})
    # @param [Hash] opts Options.
    # @option opts [String] :dname Domain name to check.
    # For testing purposes. Also, with the help of this function you can check accessibility of a domain and get its ID. For this, pass username+password+dname.
    # @return [NilClass or String] nil or Domain identifier, available only when the domain name is passed in the field domain_name/dname.
    define :nop

    # @!method get_prices(opts = {})
    # @param [Hash] opts Options.
    # @option opts [Fixnum] :show_renew_data With this flag enabled the System will return the price of registration renewal (1/0). Optional field.
    # @option opts [Fixnum] :show_update_data Флаг возврата цен для обновления домена (1/0). Необязательное поле.
    # @option opts [String] :currency Identifier of the currency in which the prices will be quoted: RUR (default), UAH, USD, EUR. Optional field.
    # Get domain registration/renewal prices in all zones available.
    # @return [Hash(currency, price_group, prices)] Prices sorted by domain zones. The prices are quoted for the period of 1 year. For some of the zones the minimum registration period exceeds 1 year. If a zone allows Cyrillic domains and the price for them differ from the price for domains in Latin characters, for such a zone the system will return an additional record with the prefix '__idn.'.
    # @note Accessibility: everyone
    # @note Support of service lists: no
    define :get_prices

    # @!method get_suggest(opts = {})
    # @param [Hash] opts Options.
    # Suggest a domain name using keywords. The function is similar to the [Reg.Choice](https://www.reg.com/domain/new/choose) service.
    # @option opts [String] :word Main keyword. For example, «domain». Mandatory field.
    # @option opts [String] :additional_word Additional keyword. For example, «new» or «best». Optional field.
    # @option opts [String/Symbol] :category The category of picked up names. Valid values: `pattern` — names matching defined patterns («name + prefix»), `search_trends` – current search trends, `all` (default) – all categories.
    # @option opts [String/Array<String>] :tlds The zone in which the domain name should be checked for availability. Valid zones: `ru`, `рф`, `su`, `com`, `net`, `org`, `biz`, `info`. If a request does not contain a single `tlds` field, the domains will be searched in all the above-mentioned zones.
    # @option opts [Boolean] :use_hyphen Use hyphens to delimit words in domain names (for example, “best- domain”). Valid values: `false` (do not use hyphens) and `true` (use hyphens). By default hyphens are not used (“bestdomain”).
    # @option opts [Boolean] :use_plural Suggest plural forms for domain names. Valid values: `false` (do not suggest plural forms) and `true` (suggest plural forms). Optional field.
    # @return [Array<Hash(name, avail_in)>] An array with domain name alternatives. Each element includes the field `name` (name alternative) and the array `avail_in` with a list of zones in which this name is available for registration. Maximum array size: 100.
    # @example Suggest for `house` and `new`
    #    RegApi2.domain.get_suggest word: 'house', additional_word: 'new', use_hyphen: false, tlds: [ :ru ]
    # @note Accessibility: partners
    # @note Support of service lists: no
    define :get_suggest, required: %w[ word ], field: :suggestions

    # @!method get_premium(opts = {})
    # Gets the list of available premium domain registration, the function works like the [Reg.Premium](https://www.reg.com/domain/new/premiumdomains) service
    # @param [Hash] opts Options.
    # @note Accessibility: partners
    # @note Support of service lists: no
    define :get_premium, field: :domains

    # @!method get_deleted(opts = {})
    # Get a list of deleted domains. The function is similar to the [Deleted Domains](https://www.reg.com/domain/new/freeing_domains) page.
    # Maximum returned elements in list equals to 50000.
    # @param [Hash] opts Options.
    # @note Accessibility: partners
    # @note Support of service lists: no
    # @example Typical usage
    #   RegApi2.domain.get_deleted(
    #       tlds:         'ru',
    #       deleted_from: '2013-10-01',
    #       deleted_to:   '2013-11-01',
    #       min_pr:       2,
    #       min_cy:       1
    #   )
    define :get_deleted, field: :domains

    # @!method check(opts = {})
    # This function serves to check availability of domains for registration.
    # @param [Hash] opts Options.
    # @note Accessibility: partners
    # @note Support of service lists: yes
    define :check, field: :domains

    # @!method create(opts = {})
    # Apply for domain name registration.
    # @param [Hash] opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: For privileged clients only
    define :create

    # @!method transfer(opts = {})
    # With the help of this function you can apply for a transfer of a domain from another registrar.
    # @param [Hash] opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: For privileged clients only
    define :transfer

    # @!method get_rereg_data(opts = {})
    # Use this function to get a list of “to be released” domains and their details. The data is updated every 90 minutes.
    # @param [Hash] opts Options.
    # @note Accessibility: clients
    # @note Support of service lists: no
    define :get_rereg_data

    # @!method set_rereg_bids(opts = {})
    # Use this function to place bids for “to be released” domains. Click [here](https://www.reg.com/domain/new/rereg) for details.
    # @param [Hash] opts Options.
    # @note Accessibility: clients. Partners can make an advance payment in the amount of 225 rub. and to pay the balance upon the successful fulfillment of the application for registration within 10 days of its execution (see the instalment parameter below). In case of choosing this payment procedure the domain will be registered, and after payment of the full amount it will be re-registered automatically on the specified data. In case of payment violation of the full amount by the due date, the pre-payment will be considered as firfeit and will not be refunded. See more information: Clauses 2.16, 2.17, 3.2.9, 6.11 of the agreement.
    # @note Support of service lists: yes
    define :set_rereg_bids

    # @!method get_user_rereg_bids(opts = {})
    # Use this function to get the list with information about bids placed on them. The list also includes domains with overbids.
    # @param [Hash] opts Options.
    # @note Accessibility: clients.
    # @note Support of service lists: yes
    define :get_user_rereg_bids

    # @!method get_docs_upload_uri(opts = {})
    # Use this function to get a hyperlink for uploading documents on .RU/.SU/.РФ domains.
    # @param [Hash] opts Options.
    # @note Accessibility: clients.
    # @note Support of service lists: no
    define :get_docs_upload_uri

    # @!method update_contacts(opts = {})
    # @param [Hash] opts Options.
    # With the help of this function you can make changes in the domain contact data.
    # @note Accessibility: clients.
    # @note Support of service lists: yes
    define :update_contacts

    # @!method update_private_person_flag(opts = {})
    # Use this function to change settings of the Private Person and Total Private Person flags (show/hide contact data in WHOIS).
    # @param [Hash] opts Options.
    # @note Accessibility: clients.
    # @note Support of service lists: yes
     define :update_private_person_flag

    # @!method register_ns(opts = {})
    # Domain registration in the NSI registry (for internatonal domains only).
    # @param [Hash] opts Options.
    # @note Accessibility: everyone.
    # @note Support of service lists: no
    define :register_ns

    # @!method delete_ns(opts = {})
    # Deletion of a domain from the NSI registry (for international domains only).
    # @param [Hash] opts Options.
    # @note Accessibility: everyone.
    # @note Support of service lists: no
    define :delete_ns

    # @!method get_nss(opts = {})
    # You can use this function to get DNSs for domains.
    # @param [Hash] opts Options.
    # @note Accessibility: clients.
    # @note Support of service lists: yes
    define :get_nss

    # @!method update_nss(opts = {})
    # Use this function to change DNS servers of the domain. Also this function enables/disables domain delegation (for partners only).
    # @param [Hash] opts Options.
    # @note Accessibility: clients.
    # @note Support of service lists: yes
    define :update_nss, field: :domains

    # @!method delegate(opts = {})
    # Use this this function to set the domain delegation flag.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :delegate

    # @!method undelegate(opts = {})
    # Use this flag to clear the domain delegation flag.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :undelegate

    # @!method transfer_to_another_account(opts = {})
    # Full transfer of a domain to another account.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :transfer_to_another_account, field: :domains

    # @!method look_at_entering_list(opts = {})
    # Use this function to view the list of domains transferred to this account.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :look_at_entering_list, field: :messages

    # @!method accept_or_refuse_entering_list(opts = {})
    # Accept or decline domains transferred to this account.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :accept_or_refuse_entering_list, field: :domains

    # @!method cancel_transfer(opts = {})
    # Use this function for cancelling domain transfers
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: yes
    define :cancel_transfer

    # @!method request_to_transfer(opts = {})
    # Send request to domain transfer.
    # @param [Hash] opts Options.
    # @note Accessibility: partners.
    # @note Support of service lists: no
    define :request_to_transfer, field: :domains

    extend self
  end
end
