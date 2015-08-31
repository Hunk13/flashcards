require 'rails_helper'
require 'capybara/rspec'

describe "Cards to review" do
  context "no cards to review" do
    before(:each) do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Тренировка слов"
    end

    it "no new cards to review" do
      expect(page).to have_content "Нет карточек для тренировки"
    end
  end

  context "have cards to review" do
    before(:each) do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Тренировка слов"
    end

    it "input wrong translation" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      select "29", from: "card_review_date_3i"
      select "August", from: "card_review_date_2i"
      click_on "Создать карточку"
      expect(page).to have_content("Back")
      click_on "Тренировка слов"
      fill_in 'review_user_translation', with: "Hello"
      click_button "Проверить"
      expect(page).to have_content "Неправильно, попробуй еще"
    end

    it "input right translation" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      select "29", from: "card_review_date_3i"
      select "August", from: "card_review_date_2i"
      click_on "Создать карточку"
      expect(page).to have_content("Back")
      click_on "Тренировка слов"
      fill_in "review_user_translation", with: "Ja"
      click_button "Проверить"
      expect(page).to have_content "Правильный перевод"
    end
  end

  context "not logged review" do
    it "not logged user review" do
      visit root_path
      click_on "Тренировка слов"
      expect(page).to have_content "Вы должны зарегистрироваться или войти со своими данными"
    end

    it "not logged user add" do
      visit root_path
      click_on "Добавить карточку"
      expect(page).to have_content "Вы должны зарегистрироваться или войти со своими данными"
    end

    it "not logged user all card" do
      visit root_path
      click_on "Все карточки"
      expect(page).to have_content "Вы должны зарегистрироваться или войти со своими данными"
    end
  end
end
