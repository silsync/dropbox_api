# frozen_string_literal: true
module DropboxApi::Endpoints::Users
  class CheckUser < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/check/user'
    ResultType  = DropboxApi::Results::CheckUserResult
    ErrorType   = DropboxApi::Errors::CheckUserError

    # Get information about a user's account.
    #
    # @return [CheckUserResult] just returns the query if it was set
    add_endpoint :check_user do |query, options = {}|
      perform_request({
        query: query
      })
    end
  end
end
