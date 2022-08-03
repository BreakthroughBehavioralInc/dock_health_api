module DockHealthApi
  module Crud
    module Get
      def get(id)
        response = execute_request(:get, "#{resource_url}/#{id}", headers: headers )
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
