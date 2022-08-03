module DockHealthApi
  module Crud
    module Delete
      def delete(**params)
        id = params.delete(:id)
        response = execute_request(:delete, "#{resource_url}/#{id}", headers: headers, body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
