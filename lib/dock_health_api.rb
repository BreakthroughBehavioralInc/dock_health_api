# Ruby bindings
require "forwardable"

# Version
require "dock_health_api/version"

require "dock_health_api/crud/get"
require "dock_health_api/crud/create"
require "dock_health_api/crud/update"
require "dock_health_api/crud/put"
require "dock_health_api/crud/delete"
require "dock_health_api/crud/list"

require "dock_health_api/config"

module DockHealthApi
  autoload :Client, "dock_health_api/client"
  autoload :Error, "dock_health_api/error"
  autoload :Object, "dock_health_api/object"
  autoload :Resource, "dock_health_api/resource"

  autoload :User, "dock_health_api/resources/user"
  autoload :Task, "dock_health_api/resources/task"
  autoload :TaskList, "dock_health_api/resources/tasklist"
  autoload :Webhook, "dock_health_api/resources/webhook"
  autoload :Patient, "dock_health_api/resources/patient"
  autoload :Developer, "dock_health_api/resources/developer"
  autoload :Organization, "dock_health_api/resources/organization"
  autoload :CustomField, "dock_health_api/resources/customfield"

  @config = DockHealthApi::Config.new

  class << self
    attr_reader :config

    extend Forwardable

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :api_secret, :api_secret=
    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :resource_url, :resource_url=
    def_delegators :@config, :token_url, :token_url=
    def_delegators :@config, :org_id, :org_id=
    def_delegators :@config, :user_id, :user_id=
    def_delegators :@config, :api, :api=
    def_delegators :@config, :iframe_token, :iframe_token=
    def_delegators :@config, :iframe_token_expires_at, :iframe_token_expires_at=
    def_delegators :@config, :token, :token=
    def_delegators :@config, :token_expires_at, :token_expires_at=

    def receive_iframe_token
      Client.active_client.iframe_token_connection if iframe_token_expired?
    end

    def iframe_token_expired?
      return Time.now > self.iframe_token_expires_at if self.iframe_token_expires_at
      true
    end

    def iframe_url(arg={})
      DockHealthApi.receive_iframe_token
      base_url = "http://dev.dockhealth.app/#/embedded?"
      view_type = arg[:view_type]
      target_type = arg[:target_type]
      target_id = arg[:target_id]

      base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{user_id}&viewType=#{view_type}&targeType=#{target_type}&targetId=#{target_id}"
    end

    def patient_task_list_url(arg={})
      receive_iframe_token
      base_url = "https://dev.dockhealth.app/#/auth/embedded?"
      view_type = "PATIENT"
      target_type = "PATIENT"
      user_id = arg[:user_id]
      target_id = arg[:patient_id]

      base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{user_id}&viewType=#{view_type}&targetType=#{target_type}&targetId=#{target_id}"
    end


    def user_task_list_url(arg={})
      receive_iframe_token
      base_url = "https://dev.dockhealth.app/#/auth/embedded?"
      user_id = arg[:user_id]

      base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{user_id}"
  end
end
