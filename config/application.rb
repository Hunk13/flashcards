require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.mail.ru",
      port: "465",
      authentication: :plain,
      user_name: ENV["MAIL_USER"],
      password: ENV["MAIL_PASSWORD"],
      enable_starttls_auto: true,
      ssl: true,
      tls: true
    }
    config.action_mailer.default_url_options = {
      host: ENV["APP_HOST"]
    }
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]
  end
end
