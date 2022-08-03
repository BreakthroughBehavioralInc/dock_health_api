module DockHealthApi
  module Crud
    module Update
      def update(**params)
        headers = {"Content-Type": "application/json", "x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
        # resource_url, params = add_organziation_user_fix(params) if params.key?(:organizationId) && params.key?(:userId)
        id = params.delete(:id)
        response = execute_request(:patch,
                                   "#{resource_url}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end

      def add_organziation_user_fix(params)
        updated_resource_url = "#{Organization.resource_url}/#{params[:organizationId]}/user"
        params[:id] = params[:userId]
        return updated_resource_url, params
      end
    end
  end
end
