class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if login(session_params[:email],
             session_params[:password],
             session_params[:remember])
      redirect_back_or_to(root_path, notice: t("controller.user_sessions.welcome"))
    else
      flash[:error] = t("controller.user_sessions.faill")
      render action: "new"
    end
  end

  def destroy
    if current_user
      logout
      redirect_to(:login, notice: t("controller.user_sessions.logged"))
    else
      redirect_to root_path
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password, :remember, :locale)
  end
end
