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
        # "#{Organization.resource_url}/#{ENV["DOCK_ORG"]}/user"
      end
    end
  end
end
