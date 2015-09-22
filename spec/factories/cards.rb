FactoryGirl.define do
  factory :card do
    original_text "Yes"
    translated_text "Ja"
    review_date Time.now
    deck
  end
end
