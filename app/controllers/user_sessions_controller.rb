class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
  end

  def create
    if login(session_params[:email], session_params[:password], session_params[:remember_me])
      redirect_back_or_to(root_path, notice: "Welcome!!!")
    else
      flash[:error] = "E-mail and/or password is incorrect."
      render action: "new"
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: "Logget out")
  end

  private
    def set_user
      @user = login(params[:email], params[:password])
    end

    def session_params
      params.require(:user).permit(:email, :password, :remember_me)
    end
  end
