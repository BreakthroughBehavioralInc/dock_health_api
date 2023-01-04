module DockHealthApi
  class UserGroup < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List
    extend DockHealthApi::Crud::Delete

    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/user/group"
    end

  end
end
  