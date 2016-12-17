def login(email, password)
  visit home_login_path
  fill_in 'login_email', with: email
  fill_in 'login_password', with: password
  click_button 'login_button'
end

def default_login
  login('aa@aa.aa', '12345')
end
