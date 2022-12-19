module DockHealthApi
  module Crud
    module Create
      def create(**params)
       execute_request(:post, resource_url, headers: headers, body_params: params)
      end
    end
  end
end
