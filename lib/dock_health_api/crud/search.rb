module DockHealthApi
  module Crud
    module Search
      def search(**params)
        execute_paged_request(resource_url, headers: headers, params: params)
      end
    end
  end
end
