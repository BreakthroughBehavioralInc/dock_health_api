module DockHealthApi
  class Organization < Resource
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::List
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::Delete

    class User < Organization
      def self.resource_url
        "#{Organization.resource_url}/#{DockHealthApi.org_id}/user"
      end

      def self.update(**params)
        resource_url_fixed = "#{Organization.resource_url}/#{params[:organizationId]}/user"
        params[:id] = params[:userId]
        id = params.delete(:id)
        response = execute_request(:patch,
                                   "#{resource_url_fixed}/#{id}",
                                   headers: headers,
                                   body_params: params)
        return response.parsed
        new(response.parsed)
      end
    end
  end
end
