module DockHealthApi
  class CustomStatus < Resource
    extend DockHealthApi::Crud::List

    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/configuration/status"
    end
  end
end
