require 'rails_helper'

describe "Cards to review" do
  context "no cards to review" do
    before(:each) do
      visit root_path
      click_link "Тренировка слов"
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

    it "input wrong translation" do
      fill_in 'review_user_translation', with: "Hello"
      click_button "Проверить"
      expect(page).to have_content "Неправильно, попробуй еще"
    end

    it "input right translation" do
      fill_in 'review_user_translation', with: "Yes"
      click_button "Проверить"
      expect(page).to have_content "Правильный перевод"
    end
  end
end