require "oauth2"

module DockHealthApi
  class Client
    attr_reader :config

    def initialize(config = {})
      @config = config
    end

    def self.active_client
      new(CignaApi.config)
    end

    def connection
      @connection ||= OAuth2::Client.new(config.api_key, config.api_secret, token_url: config.token_url, raise_errors: false)
    end

    def token_connection
      @token_connection ||= connection.client_credentials.get_token(scope: "dockhealth/system.developer.read")
    end

    def token
      @token ||= token_connection.token
    end
  end
end
