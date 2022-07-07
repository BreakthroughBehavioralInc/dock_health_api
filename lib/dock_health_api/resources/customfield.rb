module DockHealthApi
  class CustomField < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List


    def self.resource_url
      "#{client.config.resource_url}/#{url_version}/configuration/field"
    end
  end
end
