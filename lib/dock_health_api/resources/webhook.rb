module DockHealthApi
  class Webhook < Resource
    extend DockHealthApi::Crud::Create
#    extend DockHealthApi::Crud::Delete  ## Waiting for delete to be ad in crud
    extend DockHealthApi::Crud::Get
    extend DockHealthApi::Crud::Update
  end
end
