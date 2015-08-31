require "rails_helper"
require "capybara/rspec"

describe "User registration" do
  context "valid data" do
    it "new user" do
      visit signup_path
      fill_in "user_name", with: "Bill Gates"
      fill_in "user_email", with: "bill@microsoft.com"
      fill_in "user_password", with: "WindowsMustDie"
      fill_in "user_password_confirmation", with: "WindowsMustDie"
      click_button "Save"
      expect(page).to have_content "Signed up!"
    end

    it "edit user" do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Редактировать мой профиль"
      fill_in "user_name", with: "Bill Gates"
      fill_in "user_password", with: "P@ssw0rd"
      fill_in "user_password_confirmation", with: "P@ssw0rd"
      click_button "Save"
      expect(page).to have_content "Data successfully updated!"
    end

    it "user log out" do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_on "Выход"
      expect(page).to have_content "Logget out"
    end
  end

  context "invalid data" do
    it "password confirmation not eval password" do
      visit signup_path
      fill_in "user_name", with: "Bill Gates"
      fill_in "user_email", with: "bill@microsoft.com"
      fill_in "user_password", with: "WindowsMustDie"
      fill_in "user_password_confirmation", with: "p@ssw0rd"
      click_button "Save"
      expect(page).to have_content "doesn't match Password"
    end

    it "user name nil" do
      visit signup_path
      fill_in "user_name", with: nil
      fill_in "user_email", with: "bill@microsoft.com"
      fill_in "user_password", with: "WindowsMustDie"
      fill_in "user_password_confirmation", with: "WindowsMustDie"
      click_button "Save"
      expect(page).to have_content "can't be blank"
    end

    it "password nil" do
      visit signup_path
      fill_in "user_name", with: "Bill Gates"
      fill_in "user_email", with: nil
      fill_in "user_password", with: "WindowsMustDie"
      fill_in "user_password_confirmation", with: "WindowsMustDie"
      click_button "Save"
      expect(page).to have_content "can't be blank"
    end

    it "password to short" do
      visit signup_path
      fill_in "user_name", with: "Bill Gates"
      fill_in "user_email", with: "bill@microsoft.com"
      fill_in "user_password", with: "1"
      fill_in "user_password_confirmation", with: "1"
      click_button "Save"
      expect(page).to have_content "is too short (minimum is 3 characters)"
    end
  end
end