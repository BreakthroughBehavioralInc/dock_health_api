module DockHealthApi
  module Crud
    module Put
      def put(**params)
        id = params.delete(:id)
        response = execute_request(:put,
                                   "#{resource_url}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
