# frozen_string_literal: true
module DropboxApi::Endpoints::Team
  class TeamFolderList < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/team/team_folder/list'
    ResultType  = DropboxApi::Results::TeamFolderListResult
    ErrorType   = DropboxApi::Errors::TeamFolderListError

    include DropboxApi::OptionsValidator

    # Returns the contents of a folder.
    #
    # @option options limit [Numeric] If present, will specify max number of
    #   results per request (Note:
    #   {https://www.dropbox.com/developers/documentation/http/teams#team-team_folder-list Dropbox docs} indicate
    #   this is "approximate", and more may be returned)
    add_endpoint :team_folder_list do |options = {}|
      validate_options([
        :limit
      ], options)
      options[:limit] = options[:limit] if options[:limit]
      # options[:team] = true

      perform_request options
    end
  end
end
