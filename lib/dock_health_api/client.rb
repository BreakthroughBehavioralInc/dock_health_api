require "oauth2"

module DockHealthApi
  class Client
    attr_reader :config

    def initialize(config = {})
      @config = config
    end

    def self.active_client
      new(DockHealthApi.config)
    end

    def connection
      @connection ||= OAuth2::Client.new(config.api_key, config.api_secret, token_url: config.token_url, raise_errors: false)
    end

    def token_connection
      unless @token_connection
        get_token
      else
        get_token if token_expired?(DockHealthApi.token_expires_at)
      end
      @token_connection
    end

    def iframe_token_connection
      unless @iframe_token_connection
        get_iframe_token
      elseif token_expired?(DockHealthApi.iframe_toke_expires_at)
        get_iframe_token
      end
      @iframe_token_connection
    end

    def token
      @token ||= token_connection.token
    end

    def iframe_token
      @iframe_token ||= iframe_token_connection.token
    end

    def token_expired?(expires_at)
      Time.now > expires_at
    end

    def get_token
      @token_connection = connection.client_credentials.get_token(scope:"dockhealth/system.developer.read dockhealth/user.all.write dockhealth/user.all.read dockhealth/system.developer.write dockhealth/patient.all.read dockhealth/patient.all.write dockhealth/system.embedded.launch")
      DockHealthApi.token = @token_connection.token
      DockHealthApi.token_expires_at = token_expiration_time(@token_connection.expires_in)
    end

    def get_iframe_token
      @iframe_token_connection = connection.client_credentials.get_token(scope:"dockhealth/system.embedded.launch")
      DockHealthApi.iframe_token = @iframe_token_connection.token
      DockHealthApi.iframe_toke_expires_at = token_expiration_time(@iframe_token_connection.expires_in)
    end

    def token_expiration_time(expires_in)
      Time.now + expires_in
    end
  end
end
