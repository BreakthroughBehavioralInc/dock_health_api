module DockHealthApi
  module Crud
    module Create
      def create(**params)
        response = execute_request(:post,
                                   resource_url,
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
