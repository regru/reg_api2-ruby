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
    # @return [void] Nothing.
    # @note Support of service lists: no
    # @example Creation of folder
    #    RegApi2.folder.create folder_name: 'test_folder_name'
    define :create, required: %w[ folder_name ]

    # @!method remove(opts = {})
    # Removes a folder.
    # @param [Hash] opts
    # @option opts [Fixnum] :folder_id Id of folder to remove.
    # @option opts [String] :folder_name The name of folder to remove.
    # @return [void] Nothing.
    # @note Support of service lists: no
    # @example Removing of folder by id
    #    RegApi2.folder.remove folder_id: 123456
    # @example Removing of folder by name
    #    RegApi2.folder.remove folder_name: 'test_folder_name'
    define :remove

    # @!method rename(opts = {})
    # Renames a folder.
    # @param [Hash] opts
    # @option opts [Fixnum] :folder_id Id of folder to rename.
    # @option opts [String] :folder_name The name of folder to rename.
    # @option opts [String] :new_folder_name Defines the new name of folder.
    # @return [Hash(folder_content)] Folder content.
    # @note Support of service lists: no
    # @example Renaming of folder by id
    #    RegApi2.folder.rename folder_id: 123456, new_folder_name: 'new_test_folder_name'
    # @example Renaming of folder by name
    #    RegApi2.folder.rename folder_name: 'test_folder_name', new_folder_name: 'new_test_folder_name'
    define :rename, required: %w[ new_folder_name ]

    # @!method get_services(opts = {})
    # Use this function to obtain the list of services available in the folder.
    # @param [Hash] opts
    define :get_services

    # @!method add_services(opts = {})
    # Use this function to add services to folders.
    # @param [Hash] opts
    define :add_services

    # @!method remove_services(opts = {})
    # Use this function to delete services from folders.
    # @param [Hash] opts
    define :remove_services

    # @!method replace_services(opts = {})
    # This function allows replacement of services already available in a folder with other services (deletes the service available in the folder and adds the services defined by the domain_name or service_id parameter).
    # @param [Hash] opts
    define :replace_services

    # @!method move_services(opts = {})
    # Use this function to move service between folders.
    # @param [Hash] opts
    define :move_services

    extend self
  end
end
