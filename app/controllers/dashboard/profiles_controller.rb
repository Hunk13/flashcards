module Dashboard
  class ProfilesController < BaseController
    before_action :find_profile, only: [:show, :edit, :update, :destroy]

    def show
    end

    def edit
    end

    def update
      if current_user.update_attributes(user_params)
        redirect_to dashboard_profile_path, notice: t("controller.profiles.update")
      else
        render "edit"
      end
    end

    def destroy
      @user.destroy
      redirect_back_or_to root_url
    end

    private

    def find_profile
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:profile).permit(:name,
                                      :email,
                                      :password,
                                      :password_confirmation,
                                      :locale)
    end
  end
end
