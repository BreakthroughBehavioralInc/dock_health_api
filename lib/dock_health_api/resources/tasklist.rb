module DockHealthApi
  class TaskList < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List

    @@resource_url = "#{client.config.resource_url}/api/#{url_version}/list"

    def self.resource_url
      @@resource_url
    end

    class User < TaskList
      extend DockHealthApi::Crud::Create
      extend DockHealthApi::Crud::Delete
      extend DockHealthApi::Crud::Update

      def self.resource_url
        "#{@@resource_url}/user"
      end
    end
  end
end
