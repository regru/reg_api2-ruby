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

    extend self
  end
end
