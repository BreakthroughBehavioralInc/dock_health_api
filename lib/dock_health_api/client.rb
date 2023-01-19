require "oauth2"
require 'singleton'

module DockHealthApi
  class Client
    BUFFER = 120

    include Singleton
    
    attr_reader :config

    def initialize
      @config = DockHealthApi.config
    end

    def connection
      @connection ||= OAuth2::Client.new(config.api_key, config.api_secret, token_url: config.token_url, raise_errors: false)
    end

    def token_connection
      get_token if @token_connection.nil? || token_about_to_expire?
      @token_connection
    end

    def token_expiration_time
      @token_expiration_time ||= Time.now + @token_connection.expires_in
    end

    def token_about_to_expire?
      Time.now + BUFFER > token_expiration_time
    end

    def iframe_token_connection
      get_iframe_token
      @iframe_token_connection
    end

    def token
      @token ||= token_connection.token
    end

    def iframe_token
      @iframe_token ||= iframe_token_connection.token
    end

    def get_token
      @token_connection = connection.client_credentials.get_token(scope:"dockhealth/system.developer.read dockhealth/user.all.write dockhealth/user.all.read dockhealth/system.developer.write dockhealth/patient.all.read dockhealth/patient.all.write")
      @token_expiration_time = Time.now + @token_connection.expires_in
      @token_connection
    end

    def get_iframe_token
      @iframe_token_connection = connection.client_credentials.get_token(scope:"dockhealth/system.embedded.launch")
      return @iframe_token_connection if @iframe_token_connection.nil?
      DockHealthApi.iframe_token = @iframe_token_connection.token
      DockHealthApi.iframe_token_expires_at = Time.now + @iframe_token_connection.expires_in
    end
  end
end
