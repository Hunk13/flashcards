require "rails_helper"
require_relative "helpers/card_helper"

describe "Testing card create and edit," do
  context "valid card" do
    before :each do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
    end

    it "add card" do
      visit root_path
      click_on "Показать мой профиль"
      click_on "Редактировать мой профиль"
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      attach_file "Pictures for word", "#{Rails.root}/spec/fixtures/files/cat.jpg"
      click_on "Создать карточку"
      expect(page).to have_content("Back")
    end

    it "edit card" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      attach_file "Pictures for word", "#{Rails.root}/spec/fixtures/files/cat.jpg"
      click_on "Создать карточку"
      expect(page).to have_content("Back")
      click_on "Все карточки"
      click_on "Редактировать"
      fill_in("card_original_text", with: "Nein")
      fill_in("card_translated_text", with: "No")
      click_on "Создать карточку"
      expect(page).to have_content("Back")
    end
  end

  context "invalid card" do
    before :each do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
    end

    it "invalid word" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Ja")
      click_on "Создать карточку"
      expect(page).to have_content("Оригинальный и переведённый тексты равны")
    end

    it "original text nil" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: nil)
      fill_in("card_translated_text", with: "Yes")
      click_on "Создать карточку"
      expect(page).to have_content("can't be blank")
    end

    it "translated text nil" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: nil)
      click_on "Создать карточку"
      expect(page).to have_content("can't be blank")
    end
  end
end
