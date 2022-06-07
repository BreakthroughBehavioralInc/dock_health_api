module DockHealthApi
  module Crud
    module Get
      def get
        response = execute_request(:get, "#{resource_url}")
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
