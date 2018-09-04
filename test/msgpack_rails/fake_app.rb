require "action_controller/railtie"
require "active_model/railtie"

class FakeApp < Rails::Application
  config.secret_token = config.secret_key_base = "1234567890"
  config.session_store :cookie_store, key: '_myapp_session'
  config.active_support.deprecation = :log
  config.eager_load = false
  config.root = File.dirname(__FILE__)
end
Rails.backtrace_cleaner.remove_silencers!
Rails.application.initialize!

FakeApp.routes.draw do
  post ":controller/:action"
end

class ApplicationController < ActionController::Base
end
