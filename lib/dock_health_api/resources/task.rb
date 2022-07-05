module DockHealthApi
  class Task < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List

    def self.list(**params)
      headers = {"x-api-key": "#{ENV["DOCK_HEALTH_API"]}", "x-user-id": "#{ENV["DOCK_USER"]}", "x-organization-id": "#{ENV["DOCK_ORG"]}"}
      response = execute_request(:get, "#{resource_url}", headers: headers, params: params)
      return response.parsed
      new(response.parsed)
    end

    class Group < Task
      def self.resource_url
        "#{Task.resource_url}/group"
      end
    end
  end
end
