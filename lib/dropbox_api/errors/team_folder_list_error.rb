# frozen_string_literal: true
module DropboxApi::Errors
  class TeamFolderListError < BasicError
    ErrorSubtypes = {
      path: LookupError
    }.freeze
  end
end
