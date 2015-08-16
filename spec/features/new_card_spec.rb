require 'rails_helper'

describe "New card" do
  context "valid card" do
    before(:each) do
      visit new_card_path
      fill_in "card_original_text", with: "Yes"
      fill_in "card_translated_text", with: "Ja"
      click_button "Создать карточку"
    end

    it "card ok" do
      expect(page).to have_content "Back"
    end

    it "translated equal original" do
      visit new_card_path
      fill_in "card_original_text", with: "Ja"
      fill_in "card_translated_text", with: "Ja"
      click_button "Создать карточку"
      expect(page).to have_content "Оригинальный и переведённый тексты равны"
    end
  end
end