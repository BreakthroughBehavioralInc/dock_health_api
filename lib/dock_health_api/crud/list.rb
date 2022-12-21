module DockHealthApi
  module Crud
    module List
      def list(**params)
        response = execute_request(:get, "#{resource_url}", headers: headers)
        return response if client.config.debug || params.empty?
        search_result = response
        params.each do |p|
          search_result = search_result.select { |list| list[p[0].to_s] == p[1] }
        end
        return search_result
      end
    end
  end
end
