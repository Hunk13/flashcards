require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'capybara/rspec'
require 'factory_girl_rails'
require 'email_spec'

RSpec.configure do |config|
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

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
