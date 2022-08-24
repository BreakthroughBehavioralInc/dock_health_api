module DockHealthApi
  class Config
    attr_accessor :api_key, :api_secret, :api_base, :token_url, :resource_url, :org_id, :user_id, :api, :iframe_token, :token, :iframe_toke_expires_at, :token_expires_at

    def initialize
      @token_url = "https://dock-health-dev.auth.us-east-1.amazoncognito.com/oauth2/token"
    end
  end
end
