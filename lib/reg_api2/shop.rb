# -*- encoding : utf-8 -*-

module RegApi2
  # REG.API shop category
  module Shop

    include RegApi2::Builder

    category :shop

    # @!method nop
    # @param opts Opts
    # @option opts [String] :dname Domain name.
    # For testing purposes. Also, with the help of this function you can check accessibility of a lot and get its ID. For this, pass username+password+dname.
    # @return [String] lot identifier or nil.
    define :nop

    extend self
  end
end

