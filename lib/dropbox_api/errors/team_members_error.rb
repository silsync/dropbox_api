# frozen_string_literal: true # TODO / FIXME - update/correct
module DropboxApi::Errors
  class TeamMembersError < BasicError
    ErrorSubtypes = {
      path: LookupError
    }.freeze
  end
end
