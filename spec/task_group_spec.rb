require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Task::Group do
  let(:tasklistid) { DockHealthApi::TaskList.list.last["id"] }
  # tasklistid = DockHealthApi::TaskList.list.last["id"]
  let(:params) {{ groupName: "test foobar", taskList: { type: "DEVELOPER", id: tasklistid } }}
  # params = { groupName: "test foobar", taskList: { type: "DEVELOPER", id: tasklistid } }
  id = ""

  describe "#create" do
    context "create new task group" do
      it "should create new task group" do
        initial_count = DockHealthApi::Task::Group.list(taskListIdentifier: tasklistid).count
        response = DockHealthApi::Task::Group.create(params)
        final_count = DockHealthApi::Task::Group.list(taskListIdentifier: tasklistid).count
        expect(response["groupName"]).to eq(params[:groupName])
        expect(final_count - initial_count).to eq(1)
        id = response["id"]
      end
    end
  end

  describe "#list" do
    context "list task group by criteria" do
      it "should list all task groups by criteria" do
        response = DockHealthApi::Task.list(taskListIdentifier: tasklistid)
        expect(response.last.is_a?(DockHealthApi::Task::Group))
      end
    end
  end

  describe "#get" do
    # context "get a specific task group" do
    #   it "should get the correct task group" do
    #     response = DockHealthApi::Task::Group.get(id)
    #     expect(response["groupName"]).to eq(params[:groupName])
    #   end
    # end

    context "get task group with wrong id" do
      it "should return 404" do
        wrong_id = "a" * 36
        response = DockHealthApi::Task::Group.get(wrong_id)
        expect(response["status"]).to eq(500)
      end
    end
  end

  # describe "#update" do
  #   context "update existing task group" do
  #     it "should update existing task group" do
  #       new_params = { grupName: "test foobar update", id: id }
  #       response = DockHealthApi::Task::Group.update(new_params)
  #       expect(response["groupName"]).to eq(new_params[:groupName])
  #     end
  #   end
  # end

  # describe "#delete" do
  #   context "Delete existing task group" do
  #     it "should delete existing task group" do
  #       initial_count = DockHealthApi::Task::Group.list(taskListIdentifier: tasklistid).count
  #       response = DockHealthApi::Task::Group.delete(id: id)
  #       final_count = DockHealthApi::Task::Group.list(taskListIdentifier: tasklistid).count
  #       expect(response).to eq("")
  #       expect(final_count - initial_count).to eq(-1)
  #     end
  #   end
  # end

end
