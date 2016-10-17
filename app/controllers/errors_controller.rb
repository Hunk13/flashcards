class ErrorsController < ApplicationController
  skip_before_action :require_login

  def error404
    render status: :not_found
  end
end
