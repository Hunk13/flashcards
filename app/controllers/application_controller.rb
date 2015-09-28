class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, :set_locale

  def not_authenticated
    redirect_to(login_path, alert: t("controller.application.not_logged_message"))
  end

  def set_locale
    locale = detect_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  def change_locale
    l = params[:locale].to_s.strip.to_sym
    l = I18n.default_locale unless I18n.available_locales.include?(l)
    cookies.permanent[:flashcard_locale] = l
    redirect_to request.referer || root_url
  end

  private

  def detect_locale
    if current_user
      current_user.locale
    elsif params[:locale]
      session[:locale] = params[:locale]
    elsif session[:locale]
      session[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
