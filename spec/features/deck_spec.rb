require "rails_helper"
require "support/login_helper"
require "context/login_user"

describe "Deck features" do
  context "valid deck" do
    include_context "logged user"

    it "add deck" do
      visit new_deck_path
      fill_in("deck_title", with: "Animals")
      click_on "Создать колоду"
      expect(page).to have_content("Список всех колод")
    end
  end

  context "invalid deck" do
    include_context "logged user"

    it "add deck" do
      visit new_deck_path
      fill_in("deck_title", with: nil)
      click_on "Создать колоду"
      expect(page).to have_content("can't be blank")
    end
  end
end
