class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, :set_locale

  def not_authenticated
    redirect_to(login_path, alert: t("controller.application.not_logged_message"))
  end

  def set_locale
    Rails.logger.warn "detect locale"
    locale = detect_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      Rails.logger.warn "out locale"
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  private

  def detect_locale
    if current_user.try(:locale)
      Rails.logger.warn "current locale"
      current_user.locale
    elsif params[:locale]
      Rails.logger.warn "params locale"
      params[:locale]
    elsif session[:locale]
      Rails.logger.warn "sessions locale"
      session[:locale]
    else
      Rails.logger.warn "http locale1"
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
