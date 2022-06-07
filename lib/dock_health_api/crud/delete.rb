module DockHealthApi
  module Crud
    module Delete
      def delete(id)
        response = execute_request(:delete, "#{resource_url}/#{{id}}")
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
