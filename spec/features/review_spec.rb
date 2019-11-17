require "spec_helper"
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
      click_on "Добавить карту"
      fill_in "card_original_text", with: "Ja"
      fill_in "card_translated_text", with: "Yes"
      select "29", from: "card_review_date_3i"
      select "августа", from: "card_review_date_2i"
      select "08", from: "card_review_date_4i"
      select "21", from: "card_review_date_5i"
      select "Animals", from: "card_deck_id"
      click_on "Создать карту"
      expect(page).to have_content("Карта создана")
      click_on "Тренировка слов"
      fill_in "review_user_translation", with: "Catze"
      click_button "Проверить слово"
      expect(page).to have_content "Неправильно, попробуй еще."
    end

    it "input right translation" do
      visit root_path
      click_on "Добавить карту"
      fill_in "card_original_text", with: "Ja"
      fill_in "card_translated_text", with: "Yes"
      select "29", from: "card_review_date_3i"
      select "августа", from: "card_review_date_2i"
      select "Animals", from: "card_deck_id"
      click_on "Создать карту"
      expect(page).to have_content("Карта создана")
      click_on "Тренировка слов"
      fill_in "review_user_translation", with: "Ja"
      click_button "Проверить слово"
      expect(page).to have_content "Правильно. Оригинальный текст:"
    end
  end
end
