require "bundler/setup"
require "dock_health_api"
require "dotenv/load"
require "pry"

Dotenv.load


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  DockHealthApi.api_key = ENV["DOCK_HEALTH_KEY"]
  DockHealthApi.api_secret = ENV["DOCK_HEALTH_SECRET"]
  DockHealthApi.resource_url = ENV["DOCK_HEALTH_URL"]
  DockHealthApi.org_id = ENV["DOCK_ORG"]
  DockHealthApi.user_id = ENV["DOCK_USER"]
  DockHealthApi.api = ENV["DOCK_HEALTH_API"]
end
