require 'dock_health_api'
require 'spec_helper'


RSpec.describe DockHealthApi::Patient do

  let (:patient) { {firstName: "John",lastName:"Doe", mrn: "908"}}
  let (:update_patient) { {firstName: "JOHN",lastName:"Doe", mrn: "908"}}
  let (:id) {""}
  
  describe '#list' do
    context "list all patients" do
      it 'should list persons in that state' do
        response = DockHealthApi::Patient.list
        expect(response.first.is_a?(DockHealthApi::Patient))
      end
    end
  end

  describe '#create' do
    context "create a new patient" do
      it 'should list persons in that state' do
        response = DockHealthApi::Patient.create(patient)
        expect(response["firstName"]).to eq(patient[:firstName])
      end
    end
  end

  describe '#get' do
    context "get a specfic patient" do
      it 'should get the patient' do
        id = DockHealthApi::Patient.list.last["id"]
        response = DockHealthApi::Patient.get(id)
        expect(response["firstName"]).to eq(patient[:firstName])
      end
    end
  end

  describe '#update' do
    context "update a specific patient" do
      it 'should update the patient first name' do
        id = {id: DockHealthApi::Patient.list.last["id"]}
        params = update_patient.merge!(id)
        response = DockHealthApi::Patient.update(params)
        expect(response["firstName"]).to eq(update_patient[:firstName])
      end
    end
  end

  describe '#delete' do
    context "delete a specific patient" do
      it 'should delete the patient' do
        id = {id: DockHealthApi::Patient.list.last["id"]}
        response = DockHealthApi::Patient.delete(id)
        expect(response).to eq("")
      end
    end
  end
end