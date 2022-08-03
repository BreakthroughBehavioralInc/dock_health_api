require 'dock_health_api'
require 'spec_helper'


RSpec.describe DockHealthApi::Organization do

  let (:organization) { {domain: "TestOrg",name:"TESTORG", identifier: "908"}}
  let (:update_organization) { {domain: "TestOrg",name:"TESTORG!", identifier: "908"}}
  let (:id) {"6ec62151-e64a-42b0-809a-9f5d7eecdae7"}

  describe '#list' do
    context "list all organizations" do
      it 'should list all organization' do
        response = DockHealthApi::Organization.list
        expect(response.first.is_a?(DockHealthApi::Organization))
      end
    end
  end

  describe '#create' do
    context "create a new organization" do
      xit 'should create a organization' do
        response = DockHealthApi::Organization.create(organization)
        expect(response["domain"]).to eq(organization[:domain])
      end
    end
  end

  describe '#get' do
    context "get a specfic organization" do
      it 'should get the organization' do
        response = DockHealthApi::Organization.get(id)
        expect(response["domain"]).to eq(organization[:domain])
      end
    end
  end

  describe '#update' do
    context "update a specific organization" do
      it 'should update the organization first name' do
        params = update_organization.merge!({id:id})
        revert = organization.merge!({id: id})
        response = DockHealthApi::Organization.update(params)
        expect(response["domain"]).to eq(update_organization[:domain])
        DockHealthApi::Organization.update(revert)
      end
    end
  end

  describe '#delete' do
    context "delete a specific organization" do
      xit 'should delete the organization' do
        response = DockHealthApi::Organization.delete({id: id})
        expect(response).to eq("")
      end
    end
  end
end
