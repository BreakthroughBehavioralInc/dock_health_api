module DockHealthApi
  class TaskList < Resource
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Delete
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List

<<<<<<< HEAD
=======
    

>>>>>>> 593f283a8c1ec12c0d1382d8303b4c6ff636e5fb
    def self.resource_url
      "#{client.config.resource_url}/api/#{url_version}/list"
    end

    class User < TaskList
      extend DockHealthApi::Crud::Create
      extend DockHealthApi::Crud::Delete
      extend DockHealthApi::Crud::Update

      def self.resource_url
<<<<<<< HEAD
        "#{client.config.resource_url}/api/#{url_version}/list/user"
      end

=======
        "#{@@resource_url}/user"
>>>>>>> 593f283a8c1ec12c0d1382d8303b4c6ff636e5fb
      end
    end
  end
end
