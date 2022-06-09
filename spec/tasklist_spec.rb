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
        respond = DockHealthApi::TaskList.create(tasklist)
        final_count = DockHealthApi::TaskList.list.count
        expect(respond["tasklist"]).to eq(tasklist["listName"])
        expect(final_count - initial_count).to eq(1)
        # storing this id for later because TaskList.list.last is NOT
        # the last created TaskList
        id = respond["id"]
      end
    end
  end

  describe "#list" do
    context "list all TaskList" do
      it "should list all TaskList" do
        respond = DockHealthApi::TaskList.list
        expect(respond.first.is_a?(DockHealthApi::TaskList))
      end
    end
  end

  describe "#get" do
    context "get a specific TaskList" do
      it "should get the correct TaskList" do
        respond = DockHealthApi::TaskList.get(id)
        expect(respond["taskList"]).to eq(tasklist["listName"])
      end
    end
  end

  describe "#update" do
    context "update an existing TaskList" do
      it "should update an exiting TaskList" do
        params = update_tasklist.merge(id: id)
        respond = DockHealthApi::TaskList.update(params)
        expect(respond["taskList"]).to eq(update_tasklist["taskList"])
      end
    end
  end

  describe "#delete" do
    context "delete an existing TaskList" do
      it "should delete an existing TaskList" do
        initial_count = DockHealthApi::TaskList.list.count
        respond = DockHealthApi::TaskList.delete(id: id)
        final_count = DockHealthApi::TaskList.list.count
        expect(respond).to eq("")
        expect(final_count - initial_count).to eq(-1)
      end
    end
  end


end
