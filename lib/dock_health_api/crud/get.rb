module DockHealthApi
  module Crud
    module Get
      def get(id)
        execute_request(:get, "#{resource_url}/#{id}", headers: headers )
      end
    end
  end
end
