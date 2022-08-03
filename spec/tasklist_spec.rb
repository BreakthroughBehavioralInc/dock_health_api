require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::TaskList do

  let(:tasklist)  { { listName: "testlist"} }
  let(:update_tasklist) { { listName: "testlist Update"} }
  id = ""

  describe "#create" do
    context "create a new TaskList" do
      it "should create a new TaskList" do
        initial_count = DockHealthApi::TaskList.list.count
        response = DockHealthApi::TaskList.create(tasklist)
        final_count = DockHealthApi::TaskList.list.count
        id = response["id"]
        expect(response["tasklist"]).to eq(tasklist["listName"])
        expect(final_count - initial_count).to eq(1)
      end
    end
  end

  describe "#list" do
    context "list all TaskList" do
      it "should list all TaskList" do
        response = DockHealthApi::TaskList.list
        expect(response.first.is_a?(DockHealthApi::TaskList))
      end
    end
  end

  describe "#get" do
    context "get a specific TaskList" do
      it "should get the correct TaskList" do
        response = DockHealthApi::TaskList.get(id)
        expect(response["taskList"]).to eq(tasklist["listName"])
      end
    end

    context "get TaskList with invalid id" do
      it "should return 400" do
        invalid_id = "123"
        response = DockHealthApi::TaskList.get(invalid_id)
        expect(response["status"]).to eq(400)
      end
    end

    context "get TaskList with wrong id" do
      it "should return 404" do
        wrong_id = "a" * 36
        response = DockHealthApi::TaskList.get(wrong_id)
        expect(response["status"]).to eq(404)
      end
    end
  end

  describe "#update" do
    context "update an existing TaskList" do
      it "should update an exiting TaskList" do
        params = update_tasklist.merge(id: id)
        response = DockHealthApi::TaskList.update(params)
        expect(response["taskList"]).to eq(update_tasklist["taskList"])
      end
    end
  end

  describe "#delete" do
    context "delete an existing TaskList" do
      it "should delete an existing TaskList" do
        initial_count = DockHealthApi::TaskList.list.count
        response = DockHealthApi::TaskList.delete(id: id)
        final_count = DockHealthApi::TaskList.list.count
        expect(response["active"]).to be false
        expect(final_count - initial_count).to eq(-1)
      end
    end
  end


end
