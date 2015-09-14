FactoryGirl.define do
  factory :card do
    original_text "Yes"
    translated_text "Ja"
    review_date Date.today
    user_id 18
  end
end
