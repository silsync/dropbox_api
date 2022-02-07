# frozen_string_literal: true
module DropboxApi::Endpoints::Users
  class CheckUser < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/check/user'
    ResultType  = DropboxApi::Results::CheckUserResult
    ErrorType   = DropboxApi::Errors::CheckUserError

    # Get information about a user's account.
    #
    # @return [BasicAccount] Basic information about any account.
    add_endpoint :check_user do |query, options = {}|
      perform_request({
        query: query
      })
    end
  end
end
