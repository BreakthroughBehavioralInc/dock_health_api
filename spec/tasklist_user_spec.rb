require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::TaskList::User do

  taskid = DockHealthApi::TaskList.list.last["id"]
  userid = DockHealthApi::User.list.last["id"]
  params = { taskList: { type: "DEVELOPER", id: taskid }, user: { type: "DEVELOPER", id: userid } }

  describe "#put" do
    context "Add existing user to TaskList" do
      it "should add existing user to TaskList" do
        initial_count = DockHealthApi::TaskList.list.last["listUsers"].count
        response = DockHealthApi::TaskList::User.put(params)
        final_count = DockHealthApi::TaskList.list.last["listUsers"].count
        expect(response["statusCode"]).to eq("SUCCESS")
        expect(final_count - initial_count).to eq(1)
      end
    end

    context "Using bad params to add user to TaskList" do
      it "should return 400" do
        bad_params = { taskList: { type: "DEVELOPER", id: taskid } }
        initial_count = DockHealthApi::TaskList.list.last["listUsers"].count
        response = DockHealthApi::TaskList::User.put(bad_params)
        final_count = DockHealthApi::TaskList.list.last["listUsers"].count
        expect(response["status"]).to eq(400)
        expect(final_count - initial_count).to eq(0)
      end
    end

    context "Using wrong ids to add user to TaskList" do
      it "should return 404" do
        bad_params = { taskList: { type: "DEVELOPER", id: taskid }, user: { type: "DEVELOPER", id: "a" * 36 } }
        initial_count = DockHealthApi::TaskList.list.last["listUsers"].count
        response = DockHealthApi::TaskList::User.put(bad_params)
        final_count = DockHealthApi::TaskList.list.last["listUsers"].count
        expect(response["status"]).to eq(404)
        expect(final_count - initial_count).to eq(0)
      end
    end

  end

  describe "#update" do
    context "Update role for existing user in TaskList" do
      it "should update role for existing suer in TaskList" do
        role = "GUEST"
        params.merge!(userRole: role)
        response = DockHealthApi::TaskList::User.update(params)
        expect(response["userRole"]).to eq(role)
      end
    end
  end

  describe "#delete" do
    context "Delete existing user from TaskList" do
      it "should delete user from TaskList" do
        initial_count = DockHealthApi::TaskList.list.last["listUsers"].count
        response = DockHealthApi::TaskList::User.delete(params)
        final_count = DockHealthApi::TaskList.list.last["listUsers"].count
        expect(response).to eq("")
        expect(final_count - initial_count).to eq(-1)
      end
    end
  end

end
