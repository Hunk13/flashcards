def new_card
  visit root_path
  click_on "Показать мой профиль"
  click_on "Редактировать мой профиль"
  click_on "Добавить карточку"
  fill_in("card_original_text", with: "Ja")
  fill_in("card_translated_text", with: "Yes")
  attach_file "Pictures for word", "spec/fixtures/files/cat.jpg"
  click_on "Создать карточку"
end