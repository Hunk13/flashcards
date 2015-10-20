module Dashboard
  class UserSessionsController < BaseController
    def destroy
      logout
      redirect_to(:home_login, notice: t("controller.user_sessions.logout"))
    end
  end
end
