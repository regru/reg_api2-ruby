# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API domain category
  module Domain

    include RegApi2::Builder

    category :domain

    # @!method nop(opts = {})
    # @param [Hash] opts
    # @option opts [String] :dname Domain name to check.
    # For testing purposes. Also, with the help of this function you can check accessibility of a domain and get its ID. For this, pass username+password+dname.
    # @return [NilClass or String] nil or Domain identifier, available only when the domain name is passed in the field domain_name/dname.
    define :nop

    # @!method get_prices(opts = {})
    # @param [Hash] opts
    # @option opts [Fixnum] :show_renew_data With this flag enabled the System will return the price of registration renewal (1/0). Optional field.
    # @option opts [Fixnum] :show_update_data Флаг возврата цен для обновления домена (1/0). Необязательное поле.
    # @option opts [String] :currency Identifier of the currency in which the prices will be quoted: RUR (default), UAH, USD, EUR. Optional field.
    # Get domain registration/renewal prices in all zones available.
    # @return [Hash(currency, price_group, prices)] Prices sorted by domain zones. The prices are quoted for the period of 1 year. For some of the zones the minimum registration period exceeds 1 year. If a zone allows Cyrillic domains and the price for them differ from the price for domains in Latin characters, for such a zone the system will return an additional record with the prefix '__idn.'.
    # @note Accessibility: everyone
    # @note Support of service lists: no
    define :get_prices

    # @!method get_suggest(opts = {})
    define :get_suggest

    # @!method get_premium(opts = {})
    define :get_premium

    # @!method check(opts = {})
    define :check

    # @!method create(opts = {})
    define :create

    # @!method transfer(opts = {})
    define :transfer

    # @!method get_rereg_data(opts = {})
    define :get_rereg_data

    # @!method set_rereg_bids(opts = {})
    define :set_rereg_bids

    # @!method get_user_rereg_bids(opts = {})
    define :get_user_rereg_bids

    # @!method get_docs_upload_uri(opts = {})
    define :get_docs_upload_uri

    # @!method update_contacts(opts = {})
    define :update_contacts

    # @!method update_private_person_flag(opts = {})
    define :update_private_person_flag

    # @!method register_ns(opts = {})
    define :register_ns

    # @!method delete_ns(opts = {})
    define :delete_ns

    # @!method get_nss(opts = {})
    define :get_nss

    # @!method update_nss(opts = {})
    define :update_nss

    # @!method delegate(opts = {})
    define :delegate

    # @!method undelegate(opts = {})
    define :undelegate

    # @!method transfer_to_another_account(opts = {})
    define :transfer_to_another_account

    # @!method look_at_entering_list(opts = {})
    define :look_at_entering_list

    # @!method accept_or_refuse_entering_list(opts = {})
    define :accept_or_refuse_entering_list

    # @!method cancel_transfer(opts = {})
    define :cancel_transfer

    # @!method request_to_transfer(opts = {})
    define :request_to_transfer

    extend self
  end
end
