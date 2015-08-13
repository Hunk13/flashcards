FactoryGirl.define do
  factory :card do
    original_text "Ja"
    translated_text "Yes"
    review_date Date.today + 3.days
  end
end