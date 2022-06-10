require "dotenv/load"
module DockHealthApi
  module Crud
    module List
      def list(**params)
        headers = {"x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        response = execute_request(:get, "#{resource_url}", headers: headers)
        if params.empty?
          return response.parsed
        else
          search_result = response.parsed
          params.each do |p|
            search_result = search_result.select { |list| list[p[0].to_s] == p[1] }
          end
          return search_result
        end
        new(response.parsed)
      end
    end
  end
end
