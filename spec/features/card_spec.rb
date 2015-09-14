require "rails_helper"
require "support/login_helper"
require "context/login_user"

describe "Testing card create and edit," do
  context "valid card" do
    include_context "logged user"

    it "add card" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      select "Animals", from: "card_deck_id"
      click_on "Создать карточку"
      expect(page).to have_content("Карта создана")
    end

    it "edit card" do
      visit root_path
      click_on "Добавить карточку"
      fill_in("card_original_text", with: "Ja")
      fill_in("card_translated_text", with: "Yes")
      select("Animals", from: "card_deck_id")
      click_on "Создать карточку"
      expect(page).to have_content("Карта создана")
      click_on "Все карточки"
      click_on "Редактировать"
      fill_in("card_original_text", with: "Nein")
      fill_in("card_translated_text", with: "No")
      click_on "Создать карточку"
      expect(page).to have_content("Данные карты обновлены")
    end
  end

  context "invalid card" do
    include_context "logged user"

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
