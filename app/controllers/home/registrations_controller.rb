class Home::RegistrationsController < Home::BaseController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:registration][:email], params[:registration][:password])
      redirect_to root_path, notice: t("controller.registrations.signup")
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:registration).permit(:name,
                                         :email,
                                         :password,
                                         :password_confirmation,
                                         :locale)
  end
end
