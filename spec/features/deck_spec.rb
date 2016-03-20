require "rails_helper"
require "support/login_helper"
require "context/login_user"

describe "Deck features" do
  context "valid deck" do
    include_context "logged user"

    it "add deck" do
      visit new_dashboard_deck_path
      fill_in "deck_title", with: "Animals"
      click_on "Создать колоду"
      expect(page).to have_content("Список всех колод")
    end

    it "edit deck" do
      visit dashboard_decks_path
      click_on "Редактировать"
      fill_in "deck_title", with: "Birds"
      click_on "Создать колоду"
      expect(page).to have_content("Колода обновлена")
    end

    it "set default deck" do
      visit new_dashboard_deck_path
      fill_in "deck_title", with: "Animals"
      click_on "Создать колоду"
      first(:link, "Установить как текущую").click
      expect(page).to have_content("Колода установлена")
    end

    it "delete deck" do
      visit new_dashboard_deck_path
      fill_in "deck_title", with: "Animals"
      click_on "Создать колоду"
      first(:link, "Удалить").click
      expect(page).to have_content("Список всех колод")
    end
  end

  context "invalid deck" do
    include_context "logged user"

    it "add deck" do
      visit new_dashboard_deck_path
      fill_in "deck_title", with: nil
      click_on "Создать колоду"
      expect(page).to have_content("не может быть пустым")
    end
  end
end
