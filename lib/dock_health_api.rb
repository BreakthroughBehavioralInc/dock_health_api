# Ruby bindings
require "forwardable"

# Version
require "dock_health_api/version"

require "dock_health_api/crud/get"
require "dock_health_api/crud/create"
require "dock_health_api/crud/update"
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
  autoload :List, "dock_health_api/resources/list"
  autoload :Webhook, "dock_health_api/resources/webhook"

  @config = DockHealthApi::Config.new

  class << self
    attr_reader :config

    extend Forwardable

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :api_secret, :api_secret=
    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :resource_url, :resource_url=
    def_delegators :@config, :token_url, :token_url=
  end
end
