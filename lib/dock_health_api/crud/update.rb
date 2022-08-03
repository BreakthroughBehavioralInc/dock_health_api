module DockHealthApi
  module Crud
    module Update
      def update(**params)
        id = params.delete(:id)
        response = execute_request(:patch,
                                   "#{resource_url}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
