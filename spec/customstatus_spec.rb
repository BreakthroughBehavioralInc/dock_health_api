require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::CustomStatus do

  describe "#list" do
    context "list all customstatus" do
      it 'should list all customstatus' do
        response = DockHealthApi::CustomStatus.list
        expect(response.first.is_a?(DockHealthApi::CustomStatus))
      end
    end
  end
end
