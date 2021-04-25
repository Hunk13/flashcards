FactoryBot.define do
  factory :card do
    original_text { "Yes" }
    translated_text { "Ja" }
    review_date { Time.zone.now }
    picture { File.new(Rails.root + "spec/fixtures/files/Cat.jpg") }
    deck
  end
end
