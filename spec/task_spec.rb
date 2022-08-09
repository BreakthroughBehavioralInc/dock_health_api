require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Task do

  let(:tasklistid) {DockHealthApi::TaskList.list.last["id"]}
  let(:params) {{ description: "test foobar", taskList: { type: "DEVELOPER", id: tasklistid } }}
  id = ""

  describe "#create" do
    context "create new task" do
      it "should create new task" do
        response = DockHealthApi::Task.create(params)
        id = response["id"]
        expect(response["description"]).to eq(params[:description])
      end
    end
  end

  describe "#list" do
    context "list task by criteria" do
      it "should list all tasks by criteria" do
        response = DockHealthApi::Task.list(taskListIdentifier: tasklistid)
        expect(response.first.is_a?(DockHealthApi::Task))
      end
    end
  end

  describe "#get" do
    context "get a specific task" do
      it "should get the correct task" do
        response = DockHealthApi::Task.get(id)
        expect(response["description"]).to eq(params[:description])
      end
    end

    context "get task with wrong id" do
      it "should return 404" do
        wrong_id = "a" * 36
        response = DockHealthApi::Task.get(wrong_id)
        expect(response["status"]).to eq(404)
      end
    end
  end

  describe "#update" do
    context "update existing task" do
      it "should update existing task" do
        new_params = { description: "test foobar update", id: id }
        response = DockHealthApi::Task.update(new_params)
        expect(response["description"]).to eq(new_params[:description])
      end
    end
  end

  describe "#delete" do
    context "Delete existing task" do
      it "should delete existing task" do
        response = DockHealthApi::Task.delete(id: id)
        expect(response).to eq("")
      end
    end
  end

end
