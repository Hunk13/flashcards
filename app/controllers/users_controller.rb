class UsersController < ApplicationController
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
      redirect_to root_path, notice: "Signed up! Welcome!"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to user_path, notice: "Data successfully updated!"
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
