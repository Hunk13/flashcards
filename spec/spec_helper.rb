require 'capybara/rspec'
require 'factory_girl_rails'
require 'email_spec'
# require 'capybara/rails'
require 'action_mailer'
require 'email_spec'

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

abort('The Rails environment is running in production mode!') if Rails.env.production?

RSpec.configure do |config|
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    Timecop.return
  end
end
