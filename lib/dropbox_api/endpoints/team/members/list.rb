# frozen_string_literal: true
module DropboxApi::Endpoints::Team
  class ListTeamMembers < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/team/members/list_v2'
    ResultType  = DropboxApi::Results::TeamMembersResult
    ErrorType   = DropboxApi::Errors::TeamMembersError

    include DropboxApi::OptionsValidator

    # Returns the contents of a folder.
    #
    # @param path [String] The path to the folder you want to read.
    # @option options recursive [Boolean] If `true`, the list folder operation
    #   will be applied recursively to all subfolders and the response will
    #   contain contents of all subfolders. The default for this field is
    #   `false`.
    # @option options include_removed [Boolean] If `true`,
    #   {DropboxApi::Metadata::Removed} will be
    #   returned for removed teammember, otherwise
    #   {DropboxApi::Errors::NotFoundError}
    #   will be raised. The default for this field is `false`.
    # @option options limit [Numeric] If present, will specify max number of
    #   results per request (Note:
    #   {https://www.dropbox.com/developers/documentation/http/teams#team-members-list Dropbox docs} indicate
    #   this is "approximate", and more may be returned)
    add_endpoint :list_team_members do |path, options = {}|
      validate_options([
      ], options)
      options[:include_removed] ||= false
      options[:limit] = options[:limit] if options[:limit]
      
      perform_request options
    end
  end
end
