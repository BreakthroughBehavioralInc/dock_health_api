require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Client do
  let(:config) { DockHealthApi::Config.new }

  describe '#instance' do
    it 'should config new client with standard config' do
      expect(DockHealthApi::Client.instance.config).to eq(DockHealthApi.config)
    end
  end

  describe "#connection" do
    it 'should initialize an OAuth2::Client object' do
      expect(DockHealthApi::Client.instance.connection.is_a?(OAuth2::Client))
    end
  end

  describe "#token_connection" do
    let (:token_connection) { DockHealthApi::Client.instance.token_connection }

    it 'should return a OAuth2::AccessToken object' do
      expect(token_connection.is_a?(OAuth2::AccessToken))
    end

    it 'should return include a token' do
      expect(token_connection.token).to_not be(nil)
    end
  end

  describe "#get_iframe_token" do
    let (:iframe_token_connection) { DockHealthApi::Client.instance.iframe_token_connection }

    it 'should return a OAuth2::AccessToken object for iframe' do
      expect(iframe_token_connection.is_a?(OAuth2::AccessToken))
    end

    it 'should return include an iframe token' do
      expect(iframe_token_connection.token).to_not be(nil)
    end
  end
end
