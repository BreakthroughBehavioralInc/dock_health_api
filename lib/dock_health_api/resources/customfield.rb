module DockHealthApi
  class CustomField < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List

    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/configuration/field"
    end

    def self.list(**params)
      headers = {"x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": client.config.org_id}
      execute_request(:get, "#{resource_url}", headers: headers, params: params)
    end
  end
end
