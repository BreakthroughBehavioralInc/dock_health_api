module DockHealthApi
  module Crud
    module Update
      def update(params={})
        if params.key?(:organizationId) && params.key?(:userId)
          resource_url_fixed = "#{Organization.resource_url}/#{params[:organizationId]}/user"
          params[:id] = params[:userId]
        else
          resource_url_fixed = resource_url
        end
        id = params.delete(:id)
        execute_request(:patch, "#{resource_url_fixed}/#{id}", headers: headers, body_params: params)
      end
    end
  end
end
