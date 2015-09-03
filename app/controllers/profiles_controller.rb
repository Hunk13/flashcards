class ProfilesController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to profile_path, notice: "Data successfully updated!"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:profile).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
