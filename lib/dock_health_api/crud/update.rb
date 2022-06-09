require "dotenv/load"
require "pry"
module DockHealthApi
  module Crud
    module Update
      def update(**params)
        id = params.delete(:id)
        headers = {"Content-Type": "application/json", "x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        response = execute_request(:patch,
                                   "#{resource_url}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
