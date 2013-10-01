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

    # @!method create(opts = {})
    # Creates a folder.
    # @param [Hash] opts
    # @option opts [String] :folder_name The name of the new folder.
    # @return [nil] nil.
    # @note Support of service lists: no
    # @example Creation of folder
    #    RegApi2.folder.create folder_name: 'test_folder_name'
    define :create, required: %w[ folder_name ]

    # @!method remove(opts = {})
    # Removes a folder.
    # @param [Hash] opts
    # @option opts [Fixnum] :folder_id Id of folder to remove.
    # @option opts [String] :folder_name The name of folder to remove.
    # @return [nil] nil.
    # @note Support of service lists: no
    # @example Removing of folder by id
    #    RegApi2.folder.remove folder_id: 123456
    # @example Removing of folder by name
    #    RegApi2.folder.remove folder_name: 'test_folder_name'
    define :remove

    extend self
  end
end
