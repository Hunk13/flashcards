require "rails_helper"

describe "Deck features" do
  context "valid deck" do
    before :each do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Добавить колоду"
    end

    it "add deck" do
      visit new_deck_path
      fill_in("deck_title", with: "Animals")
      click_on "Создать колоду"
      expect(page).to have_content("Список всех колод")
    end
  end

  context "invalid deck" do
    before :each do
      FactoryGirl.create(:user, email: "vasya@pupkin.ru", password: "12345")
      login("vasya@pupkin.ru", "12345")
      click_link "Добавить колоду"
    end

    it "add deck" do
      visit new_deck_path
      fill_in("deck_title", with: nil)
      click_on "Создать колоду"
      expect(page).to have_content("can't be blank")
    end
  end
end