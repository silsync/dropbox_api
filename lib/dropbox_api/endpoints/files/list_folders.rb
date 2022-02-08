# frozen_string_literal: true
module DropboxApi::Endpoints::Files
  class ListFolders < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/sharing/list_folders'
    ResultType  = DropboxApi::Results::ListFolderResult
    ErrorType   = DropboxApi::Errors::ListFolderError

    include DropboxApi::OptionsValidator

    # Lists all folders.
    #
    # @param path [String] The path to the folder you want to read.
    # @option options recursive [Boolean] If `true`, the list folder operation
    #   will be applied recursively to all subfolders and the response will
    #   contain contents of all subfolders. The default for this field is
    #   `false`.
    # @option options include_media_info [Boolean] If `true`, media_info
    #   is set for photo and video. The default for this field is `false`.
    # @option options include_deleted [Boolean] If `true`,
    #   {DropboxApi::Metadata::Deleted} will be
    #   returned for deleted file or folder, otherwise
    #   {DropboxApi::Errors::NotFoundError}
    #   will be raised. The default for this field is `false`.
    # @option options limit [Numeric] If present, will specify max number of
    #   results per request (Note:
    #   {https://www.dropbox.com/developers/documentation/http/documentation#files-list_folder Dropbox docs} indicate
    #   this is "approximate", and more may be returned)
    add_endpoint :list_folders do |options = {}|
      validate_options([
        :limit
      ], options)
      options[:limit] = options[:limit] if options[:limit]
      
      perform_request options.merge({
      })
    end

    private

    def build_shared_link_param(shared_link_param)
      case shared_link_param
      when String, Symbol
        DropboxApi::Metadata::SharedLink.new shared_link_param
      when DropboxApi::Metadata::SharedLink
        shared_link_param
      else
        raise ArgumentError, "Invalid `shared_link`: #{shared_link.inspect}"
      end.to_hash
    end
  end
end
