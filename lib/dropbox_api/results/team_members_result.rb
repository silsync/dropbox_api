# frozen_string_literal: true
module DropboxApi::Results
  class TeamMembersResult < DropboxApi::Results::Base
    def members
      @data['members']
    end

    def cursor
      @data['cursor']
    end

    def has_more
      @data['has_more']
    end
  end
end
