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

    # @!method add_lot
    # @param opts Opts
    # adding lot/lots.
    # @return [void] Nothing.
    define :add_lot

    # @!method update_lot
    # @param opts Opts
    # Update lot/lots.
    # @return [void] Nothing.
    define :update_lot

    # @!method delete_lot
    # @param opts Opts
    # @option opts [String] :dname Domain list.
    # delete lot/lots.
    # @return [void] Nothing.
    define :delete_lot, required: { dname: {} }

    # @!method get_info
    # @param opts Opts
    # @option opts [String] :dname Domain list.
    # obtain information on the lot.
    # @return [Hash] Lots data.
    define :get_info, required: { dname: {} }

    # @!method get_lot_list
    # @param opts Opts
    # @option opts [Boolean] :show_my_lots "Only my items" flag.
    # @option opts [Fixnum] :pg what page to show, by default - 0.
    # @option opts [Fixnum] :itemsonpage how many items per page, by default - 25, possible values: 25, 50, 100, 200, 500.
    # getting a list of lots.
    # @return [Hash] Lots data.
    define :get_lot_list

    # @!method get_category_list
    # @param opts Opts
    # getting a list of categories.
    # @return [Array] List of categories.
    define :get_category_list, field: :category_list

    # @!method get_category_list
    # @param opts Opts
    # @option opts [Fixnum] :limit the number of tags, optional, default 10, maximum 50.
    # getting a list of popular tags.
    # @return [Array] List of tags.
    define :get_suggested_tags, field: :tags

    extend self
  end
end

