require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::CustomField do

  let(:params) { {targetType: "TASK", fieldCategoryType: "PATIENT_PERSONAL", fieldType: "TEXT", name: "test1234" }
  id = ""
  describe "#list" do
    context "list all customfield" do
      it 'should list all customfield' do
        response = DockHealthApi::CustomField.list
        expect(response.first.is_a?(DockHealthApi::CustomField))
      end
    end
  end

  describe "#create" do
    context "create a new customfield" do
      it 'should create a new customfield' do
        response = DockHealthApi::CustomField.create(params)
        expect(response["name"]).to eq(params["name"])
        id = response["id"]
      end
    end
  end

  describe "#get" do
    context "find a specific customfield" do
      it 'should find the specific customfield' do
        response = DockHealthApi::CustomField.get(id)
        expect(response["name"]).to eq(params["name"])
      end
    end
  end

  describe "#update" do
    context "update customfield" do
      it 'should update the customfield' do
        response = DockHealthApi::CustomField.update(id: id, name: "update")
        expect(response["name"]).to eq("update")
      end
    end
  end

  # describe "#delete" do
  #   context "delete customfield" do
  #     it 'should delete the customfield' do
  #       response = DockHealthApi::CustomField.delete(id: id)
  #     end
  #   end
  # end
end
