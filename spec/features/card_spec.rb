require 'rails_helper'

describe "Cards to review" do
  context "no cards to review" do
    before(:each) do
      visit root_path
    end

    it "no new cards to review" do
      expect(page).to have_content "Нет карточек для тренировки"
     end
  end


  context "new cards to review" do
    before(:each) do
      card = create(:card)
      visit root_path
    end

    it "input right translation" do
      fill_in "Введите перевод слова:", with: "Yes"
      click_button "Проверить"
      expect(page).to have_content "Правильный перевод"
    end

    it "input wrong translation" do
      fill_in "Введите перевод слова:", with: "yes"
      click_button "Проверить"
      expect(page).to have_content "Неправильно, попробуй еще"
    end
  end
end