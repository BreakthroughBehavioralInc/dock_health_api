module DockHealthApi
  class Organization < Resource
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::List
    extend DockHealthApi::Crud::Create
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::Delete
  end
end