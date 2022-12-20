require 'dock_health_api'
require 'spec_helper'


RSpec.describe DockHealthApi::User do

  let (:user) { {firstName: "John",lastName:"Doe", email: "johndoe@mail.com"}}
  let (:update_user) { {firstName: "JOHN",lastName:"Doe",email: "johndoe@mail.com"}}
  let (:message) {"User is still an active member of one or more organizations."}
  let (:id) {{id: "3261c2b9-80b4-4e9e-9412-bf1a2482df0b"}}

  describe '#list' do
    context "list all users" do
      it 'should list all users' do
        response = DockHealthApi::User.list
        expect(response.first.is_a?(DockHealthApi::User))
      end
    end
  end

  # skipping create because user cannot be deleted after but create works as expected
  describe '#create' do
    context "create a new user" do
      xit 'should create a user' do
        response = DockHealthApi::User.create(user)
        expect(response["firstName"]).to eq(user[:firstName])
      end
    end
  end

  describe '#get' do
    context "get a specfic user" do
      it 'should get the user' do
        response = DockHealthApi::User.get(id[:id])
        expect(response["firstName"]).to eq(user[:firstName])
      end
    end
  end

  describe '#update' do
    context "update a specific user" do
      it 'should update the user first name' do
        params = update_user.merge!(id)
        response = DockHealthApi::User.update(params)
        expect(response["firstName"]).to eq(update_user[:firstName])
        revert_user = user.merge!(id)
        DockHealthApi::User.update(revert_user)
      end
    end
  end

  describe '#delete' do
    context "delete a specific user" do
      it 'should not delete the user due to user being active' do
        response = DockHealthApi::User.delete(id)
        expect(response["message"]).to eq(message)
      end
    end
  end
end
