module DockHealthApi
  module Crud
    module Update
      def update(id, **params)
        response = execute_request(:put,
                                   "#{resource_url}/#{id}",
                                   headers: {"Content-Type": "application/json"},
                                   body_params: params)
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
