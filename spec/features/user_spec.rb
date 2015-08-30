require 'rails_helper'

describe "User check" do
  before :each do
    FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
    login("vasya@pupkin.ru", "12345")
  end

  it 'Real estate agent sign up' do
    visit signup_path
    fill_in 'user_name', with: 'Jane Doe'
    fill_in 'user_email', with: 'newagent@example.com'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'user[password_confirmation]', with: 'newpassword'
    click_button 'Save'
    expect(page).to have_content "Signed up!"
  end

  it 'User log out' do
    login(:user_email,:user_password)
    click_on "Выход"
    expect(page).to have_content "Logget out"
  end
end