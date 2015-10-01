def login(email, password)
  visit login_path
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button I18n.t("views.user_sessions.login")
end

def default_login
  login("aa@aa.aa", "12345")
end
