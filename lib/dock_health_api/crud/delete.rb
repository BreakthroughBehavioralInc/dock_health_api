module DockHealthApi
  module Crud
    module Delete
      def delete(**params)
        id = params.delete(:id)
        execute_request(:delete, "#{resource_url}/#{id}", headers: headers, body_params: params)
      end
    end
  end
end
