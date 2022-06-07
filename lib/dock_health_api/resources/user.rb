module DockHealthApi
  class User < Resource
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Create
  end
end