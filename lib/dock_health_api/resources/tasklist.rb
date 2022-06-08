module DockHealthApi
  class TaskList < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List

    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/list"
    end

    class User < TaskList
      extend DockHealthApi::Crud::Put

      def self.resource_url
        "#{client.config.resource_url}/api/#{url_version}/list/user"
      end
    end
  end
end
