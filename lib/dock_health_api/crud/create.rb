module DockHealthApi
  module Crud
    module Create
      def create(**params)
        headers = params[:headers] ? params.delete(:headers).merge({"Content-Type": "application/json"}) : params.merge({"Content-Type": "application/json"})
        response = execute_request(:post,
                                   resource_url,
                                   headers: headers,
                                   body_params: params)
        return response.parsed if response.error
        new(response.parsed)
      end
    end
  end
end
