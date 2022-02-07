# frozen_string_literal: true
module DropboxApi::Endpoints::Users
  class GetAccount < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/check/user'
    ResultType  = DropboxApi::Results::CheckUserResult
    ErrorType   = DropboxApi::Errors::CheckUserError

    # Get information about a user's account.
    #
    # @return [BasicAccount] Basic information about any account.
    add_endpoint :check_user do |options = {}|
      perform_request
    end
  end
end
