require "rails_helper"
require "support/login_helper"
require "context/login_user"

describe "User registration" do
  context "valid data" do
    it "new user" do
      visit home_signup_path
      fill_in "registration_name", with: "Bill Gates"
      fill_in "registration_email", with: "bill@microsoft.com"
      fill_in "registration_password", with: "WindowsMustDie"
      fill_in "registration_password_confirmation", with: "WindowsMustDie"
      click_button "Сохранить"
      expect(page).to have_content "Вход произведен! Добро пожаловать!"
    end

    it "edit user" do
      create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Редактировать мой профиль"
      fill_in "profile_name", with: "Bill Gates"
      fill_in "profile_password", with: "P@ssw0rd"
      fill_in "profile_password_confirmation", with: "P@ssw0rd"
      click_button "Сохранить"
      expect(page).to have_content "Данные успешно обновлены!"
    end

    it "user log out" do
      create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_on "Выход"
      expect(page).to have_content "Сессия окончена"
    end

    it "user delete" do
      create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_on "Показать мой профиль"
      click_on "Удалить мой профиль"
      expect(page).to have_content "Вам нужно зарегистрироваться или войти со своими данными"
    end
  end

  context "invalid data" do
    it "password confirmation not eval password" do
      visit home_signup_path
      fill_in "registration_name", with: "Bill Gates"
      fill_in "registration_email", with: "bill@microsoft.com"
      fill_in "registration_password", with: "WindowsMustDie"
      fill_in "registration_password_confirmation", with: "p@ssw0rd"
      click_button "Сохранить"
      expect(page).to have_content "не совпадает со значением поля Password"
    end

    it "user name nil" do
      visit home_signup_path
      fill_in "registration_name", with: nil
      fill_in "registration_email", with: "bill@microsoft.com"
      fill_in "registration_password", with: "WindowsMustDie"
      fill_in "registration_password_confirmation", with: "WindowsMustDie"
      click_button "Сохранить"
      expect(page).to have_content "не может быть пустым"
    end

    it "password nil" do
      visit home_signup_path
      fill_in "registration_name", with: "Bill Gates"
      fill_in "registration_email", with: nil
      fill_in "registration_password", with: "WindowsMustDie"
      fill_in "registration_password_confirmation", with: "WindowsMustDie"
      click_button "Сохранить"
      expect(page).to have_content "не может быть пустым"
    end

    it "password to short" do
      visit home_signup_path
      fill_in "registration_name", with: "Bill Gates"
      fill_in "registration_email", with: "bill@microsoft.com"
      fill_in "registration_password", with: "1"
      fill_in "registration_password_confirmation", with: "1"
      click_button "Сохранить"
      expect(page).to have_content "недостаточной длины (не может быть меньше 3 символов)"
    end
  end
end
