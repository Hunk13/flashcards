require "rails_helper"
require "support/login_helper"
require "context/login_user"

describe "Cards to review" do
  let!(:deck) { create(:deck) }

  context "no cards to review" do
    include_context "logged user"

    it "no new cards to review" do
      click_on "Тренировка слов"
      expect(page).to have_content "Нет карточек для тренировки"
    end
  end

  context "have cards to review" do
    include_context "logged user"

    it "input wrong translation" do
      visit root_path
      click_on "Добавить карточку"
      fill_in "card_original_text", with: "Ja"
      fill_in "card_translated_text", with: "Yes"
      select "29", from: "card_review_date_3i"
      select "August", from: "card_review_date_2i"
      select "08", from: "card_review_date_4i"
      select "21", from: "card_review_date_5i"
      select "Animals", from: "card_deck_id"
      click_on "Создать карточку"
      expect(page).to have_content("Карта создана")
      click_on "Тренировка слов"
      fill_in "review_user_translation", with: "Catze"
      click_button "Проверить"
      expect(page).to have_content "Неправильно, попробуй еще."
    end

    it "input right translation" do
      visit root_path
      click_on "Добавить карточку"
      fill_in "card_original_text", with: "Ja"
      fill_in "card_translated_text", with: "Yes"
      select "29", from: "card_review_date_3i"
      select "August", from: "card_review_date_2i"
      select "Animals", from: "card_deck_id"
      click_on "Создать карточку"
      expect(page).to have_content("Карта создана")
      click_on "Тренировка слов"
      fill_in "review_user_translation", with: "Ja"
      click_button "Проверить"
      expect(page).to have_content "Правильно. Оригинальный текст:"
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
