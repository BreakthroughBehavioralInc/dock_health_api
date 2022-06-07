require "dotenv/load"
module DockHealthApi
  module Crud
    module Create
      def create(**params)
        headers = {"Content-Type": "application/json", "x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        response = execute_request(:post,
                                   resource_url,
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
