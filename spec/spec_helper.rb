ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'simplecov'
require 'capybara/poltergeist'

SimpleCov.start 'rails'

Capybara.javascript_driver = :poltergeist

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # Disable this since database_cleaner does the same thing and more
  config.use_transactional_fixtures = false
  config.order = "random"
  I18n.enforce_available_locales = false
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.include FactoryGirl::Syntax::Methods
  config.include SessionHelpers
end
