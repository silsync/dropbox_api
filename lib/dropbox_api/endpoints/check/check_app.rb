# frozen_string_literal: true
module DropboxApi::Endpoints::Users
  class CheckApp < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/check/user'
    ResultType  = DropboxApi::Results::CheckAppResult
    ErrorType   = DropboxApi::Errors::CheckAppError

    # Get information about an app.
    #
    # @return [CheckAppResult] just returns the query if it was set
    add_endpoint :check_app do |query, options = {}|
      perform_request({
        query: query
      })
    end
  end
end
