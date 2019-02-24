source 'http://rubygems.org'

gem 'rails', '~> 4.2.10'
gem 'pg', '~> 0.20.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'simple_form'
gem 'sorcery'
gem 'validates_email_format_of'
gem 'figaro'
gem 'paperclip', '~> 6.0.0'
gem 'aws-sdk', '~> 2.3.0'
gem 's3_direct_upload'
gem 'damerau-levenshtein'
gem 'whenever', require: false
gem 'http_accept_language'
gem 'rails-i18n', '~> 4.0.0'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'
gem 'puma'
gem 'bootstrap_form'
gem 'sshkit', github: 'capistrano/sshkit'
gem 'paperclip-dropbox'

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
  gem 'rspec-rails', '~> 3.0'
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
