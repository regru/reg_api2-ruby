# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API hosting category
  module Hosting

    include RegApi2::Builder

    category :hosting

    # @!method nop(opts = {})
    # @param [Hash] opts
    # This function serves for testing purposes.
    # @return [void] Nothing.
    # @note Accessibility: everyone
    # @example Test
    #    RegApi2.hosting.nop
    define :nop

    # @!method get_jelastic_refill_url(opts = {})
    # @param [Hash] opts
    # Gets Jelastic refill URL for current reseller.
    # @return [String] Jelastic refill URL.
    # @note Accessibility: partners
    # @example Typical usage
    #    puts RegApi2.get_jelastic_refill_url
    define :get_jelastic_refill_url, field: :url

    # @!method set_jelastic_refill_url(opts = {})
    # @param [Hash] opts
    # @option opts [String] :url Jelastic refill URL.
    # Sets Jelastic refill URL for current reseller.
    # @return [void] Nothing.
    # @note Accessibility: partners
    # @example Typical usage
    #    RegApi2.set_jelastic_refill_url url: 'http://mysite.com?service_id=<service_id>&email=<email>'
    define :set_jelastic_refill_url, required: :url

    extend self
  end
end
