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
    define :nop

    extend self
  end
end
