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
  autoload :CustomStatus, "dock_health_api/resources/customstatus"
  autoload :UserGroup, "dock_health_api/resources/usergroup"

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
    def_delegators :@config, :debug, :debug=
    def_delegators :@config, :iframe_base_url, :iframe_base_url=

    def receive_iframe_token
      @receive_iframe_token ||= Client.instance.iframe_token_connection
    end

    def iframe_token
      receive_iframe_token.token
    end

    def iframe_url(arg={})
      receive_iframe_token
      dock_user_id = arg[:user_id]
      view_type = arg[:view_type]
      target_type = arg[:target_type]
      target_id = arg[:target_id]

      iframe_base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{dock_user_id}&viewType=#{view_type}&targetType=#{target_type}&targetId=#{target_id}"
    end

    def patient_url(arg={})
      receive_iframe_token
      view_type = "PATIENT"
      target_type = "PATIENT"
      dock_user_id = arg[:user_id]
      target_id = arg[:patient_id]

      iframe_base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{dock_user_id}&viewType=#{view_type}&targetType=#{target_type}&targetId=#{target_id}"
    end


    def user_url(arg={})
      receive_iframe_token
      dock_user_id = arg[:user_id]

      iframe_base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{dock_user_id}"
    end

    def tasklist_url(arg={})
      receive_iframe_token
      view_type = "LIST"
      target_type = "LIST"
      target_id = arg[:tasklist_id]

      iframe_base_url+"authToken=#{iframe_token}&dockOrganizationId=#{org_id}&dockUserId=#{user_id}&viewType=#{view_type}&targetType=#{target_type}&targetId=#{target_id}"
    end
  end
end
