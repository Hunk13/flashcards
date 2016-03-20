source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Bootstrap
gem 'bootstrap-sass'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use SimpleForm as FormBuilder
gem 'simple_form'
# User Authentication
gem 'sorcery'
# check e-mail
gem 'validates_email_format_of'
# using ENV and a single YAML file
gem 'figaro'
# attechment library for ActiveRecord
gem 'paperclip', '~> 4.3'
# for AWS storage
gem 'aws-sdk', '~> 1.6'
# direct upload form helper and assets
gem 's3_direct_upload'
# Levenshtein distance between two byte strings
gem "damerau-levenshtein"
# Writing and deploying cron jobs
gem 'whenever', require: false
# Detect the users preferred language
gem "http_accept_language"
# Internationalization
gem 'rails-i18n', '~> 4.0.0'
# Rollbar notifier for Ruby
gem 'rollbar', '~> 2.2.1'
# Relic Ruby Agent
gem 'newrelic_rpm'
# send e-mail
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'
# Puma is the application server
gem 'puma'
# Rails Bootstrap Forms is a  it super easy to integrate bootstrap-style
gem 'bootstrap_form'

# Use Capistrano for deployment
group :development do
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # rspec-rails is a testing framework for Rails 3.x and 4.x.
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  # output formatting table
  gem "table_print"
  gem "timecop"
end

group :production do
  gem 'rails_12factor'
end

gem "codeclimate-test-reporter", group: :test, require: nil

group :test do
  gem 'email_spec'
end
