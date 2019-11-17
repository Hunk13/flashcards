source 'http://rubygems.org'

gem 'rails', '4.2.11'
gem 'pg', '~> 0.15'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'jbuilder'
gem 'simple_form'
gem 'sorcery'
gem 'validates_email_format_of'
gem 'figaro'
gem 'paperclip'
gem 'paperclip-dropbox'
gem 'aws-sdk'
gem 's3_direct_upload'
gem 'damerau-levenshtein'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'rails-i18n'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'mailgun-ruby', require: 'mailgun'
gem 'puma'
gem 'bootstrap_form'
gem 'sshkit', github: 'capistrano/sshkit'

group :development do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-nginx'
  gem 'capistrano3-puma'
  gem 'capistrano-rails'
  gem 'capistrano-rails-db'
  gem 'capistrano-rails-console'
  gem 'capistrano-upload-config'
  gem 'sshkit-sudo'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'table_print'
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
end

gem 'codeclimate-test-reporter', group: :test, require: nil

group :test do
  gem 'email_spec'
end
