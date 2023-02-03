require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Task::Comment do
  let(:tasklistid) {DockHealthApi::TaskList.list.last["id"]}
  let(:task) { DockHealthApi::Task.create({ description: "test foobar", taskList: { type: "DEVELOPER", id: tasklistid } }) }
  let(:params) { { comment: "initial comment", task: { type: "TASK", id: task["id"] }} }
  let!(:comment) { DockHealthApi::Task::Comment.create(params) }

  describe "#create" do
    context "create new task comment" do
      let(:new_comment_params) { { comment: "new comment", task: { type: "TASK", id: task["id"] }} }
        
      it "should create new task comment" do
        initial_count = DockHealthApi::Task::Comment.list(taskIdentifier: task["id"]).count
        response = DockHealthApi::Task::Comment.create(new_comment_params)
        final_count = DockHealthApi::Task::Comment.list(taskIdentifier: task["id"]).count
        expect(response["comment"]).to eq(new_comment_params[:comment])
        expect(final_count - initial_count).to eq(1)
      end
    end
  end

  describe "#list" do
    context "list task comment by criteria" do
      it "should list all task comments by criteria" do
        response = DockHealthApi::Task::Comment.list(taskIdentifier: task["id"])
        expect(response.last.is_a?(DockHealthApi::Task::Comment))
      end
    end
  end

  describe "#get" do
    context "get a specific task comment" do
      it "should get the correct task comment" do
        response = DockHealthApi::Task::Comment.get(comment["id"])
        expect(response["comment"]).to eq(params[:comment])
      end
    end

    context "get task comment with wrong id" do
      it "should return 404" do
        wrong_id = "a" * 36
        response = DockHealthApi::Task::Comment.get(wrong_id)
        expect(response["status"]).to eq(500)
      end
    end
  end

  describe "#update" do
    context "update existing task comment" do
      it "should update existing task comment" do
        update_params = { comment: "updated text", id: comment["id"] }
        response = DockHealthApi::Task::Comment.update(update_params)
        expect(response["comment"]).to eq(update_params[:comment])
        updated_task = DockHealthApi::Task::Comment.get(comment["id"])
        expect(updated_task["comment"]).to eq(update_params[:comment])
      end
    end
  end

  describe "#delete" do
    context "Delete existing task comment" do
      it "should delete existing task comment" do
        initial_count = DockHealthApi::Task::Comment.list(taskIdentifier: task["id"]).count
        response = DockHealthApi::Task::Comment.delete(id: comment["id"])
        final_count = DockHealthApi::Task::Comment.list(taskIdentifier: task["id"]).count
        expect(initial_count - final_count).to eq(1)
      end
    end
  end
end