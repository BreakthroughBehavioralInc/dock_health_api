module DockHealthApi
  class Webhook < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Put
    extend DockHealthApi::Crud::List

    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/developer/#{class_name.downcase}"
    end

  end
end
