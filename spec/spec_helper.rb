require "capybara/rspec"
require "factory_girl_rails"

Capybara.configure do |config|
  config.default_wait_time = 10
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
