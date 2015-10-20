class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale, :require_login

  def not_authenticated
    redirect_to(home_login_path, alert: t("controller.not_logged_message"))
  end

  def set_locale
    locale = detect_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  private

  def detect_locale
    if current_user.try(:locale)
      current_user.locale
    elsif params[:locale]
      params[:locale]
    elsif session[:locale]
      session[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
