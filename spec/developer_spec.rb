require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Developer do
  describe '#list' do
    context "list all developers" do
      it 'should list all developer' do
        response = DockHealthApi::Developer.list
        expect(response.first.is_a?(DockHealthApi::Developer))
      end
    end
  end
end