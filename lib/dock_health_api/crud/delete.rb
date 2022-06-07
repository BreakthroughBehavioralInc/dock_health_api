require "dotenv/load"
module DockHealthApi
  module Crud
    module Delete
      def delete(id)
        headers = {"x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        response = execute_request(:delete, "#{resource_url}/#{id}", headers: headers )
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
