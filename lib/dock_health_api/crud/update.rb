module DockHealthApi
  module Crud
    module Update
      def update(id, **params)
        headers = {"Content-Type": "application/json", "x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        response = execute_request(:put,
                                   "#{resource_url}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
