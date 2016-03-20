module Dashboard
  class UserSessionsController < BaseController
    def destroy
      logout
      redirect_to(:home_login, notice: t("controller.user_sess.logout"))
    end
  end
end
