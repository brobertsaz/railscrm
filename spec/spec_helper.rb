require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/dsl'
require 'capybara/rails'
require 'database_cleaner'
require 'support/vcr_support'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  
  config.mock_with :rspec
  config.include Mongoid::Matchers
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.extend  VCR::RSpec::Macros

  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end

