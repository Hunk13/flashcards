class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if login(session_params[:email],
             session_params[:password],
             session_params[:remember])
      redirect_back_or_to(root_path, notice: "Welcome!!!")
    else
      flash[:error] = "Login failed!!!"
      render action: "new"
    end
  end

  def destroy
    if current_user
      logout
      redirect_to(:login, notice: "Logged")
    else
      redirect_to root_path
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password, :remember)
  end
end
