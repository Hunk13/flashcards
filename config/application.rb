require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    config.before_configuration do
      env_file = File.join(Rails.root, "config", "local_env.yml")
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.active_record.raise_in_transactional_callbacks = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.mailgun.org",
      port: 587,
      authentication: :plain,
      domain: ENV["MAILGUN_DOMAIN"],
      user_name: ENV["MAIL_USER"],
      password: ENV["MAIL_PASSWORD"],
      enable_starttls_auto: true
    }
    config.action_mailer.default_url_options = {
      host: ENV["APP_HOST"]
    }
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]
  end
end
