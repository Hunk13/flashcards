class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  before_action :logged_in_user, only: [:edit, :update]
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      flash[:success] = 'Welcome!'
      redirect_to root_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, only_path: true
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
