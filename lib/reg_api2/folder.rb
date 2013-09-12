# -*- encoding : utf-8 -*-
module RegApi2
  # REG.API folder category
  module Folder

    include RegApi2::Builder

    category :folder

    # @!method nop(opts = {})
    # @param [Hash] opts
    # @option opts [String] :folder_name Folder name to check.
    # @option opts [String] :folder_id Folder id to check.
    # You can use this test function to check the availability of folders.
    # @return [Hash(id, name)] Folder data.
    # @note Support of service lists: no
    # @example Initialization with ID
    #    RegApi2.folder.nop folder_id: 123456
    # @example Initialization with name
    #    RegApi2.folder.nop folder_name: "test_folder_name"
    define :nop

    extend self
  end
end
