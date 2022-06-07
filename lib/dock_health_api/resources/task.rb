module DockHealthApi
  class Task < Resource
    extend DockHealthApi::Crud::Create
#    extend DockHealthApi::Crud::Delete  ## Waiting for delete to be ad in crud
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
    extend DockHealthApi::Crud::List
  end
end
