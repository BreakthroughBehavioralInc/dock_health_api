require "dotenv/load"
module DockHealthApi
  module Crud
    module Get
      def get
        response = execute_request(:get, "#{resource_url}", headers: {"x-api-key": "#{ENV["DOCK_HEALTH_API"]}" ,"x-user-id": "1", "x-organization-id": "1"} )
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
