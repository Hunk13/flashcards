require "rails_helper"

describe Card do
  it "is valid card with original text, translated test and date review" do
    valid_card = Card.new(
      original_text: "Ja",
      translated_text: "Yes",
      review_date: 3.days.from_now)
    expect(valid_card).to be_valid
  end

  it "is invalid card without an original text" do
    invalid_card = Card.new(original_text: nil)
    invalid_card.valid?
    expect(invalid_card.errors[:original_text]).to include("can't be blank")
  end

  it "is invalid card without a translated text" do
    invalid_card = Card.new(translated_text: nil)
    invalid_card.valid?
    expect(invalid_card.errors[:translated_text]).to include("can't be blank")
  end

  it "is invalid card without a date review" do
    invalid_card = Card.new(review_date: nil)
    invalid_card.valid?
    expect(invalid_card.errors[:review_date]).to include("can't be blank")
  end

  it "is invalid card with original text and translated text equal" do
    invalid_card = Card.new(
      original_text: "ja",
      translated_text: "ja")
    invalid_card.valid?
    expect(invalid_card.errors[:original_text]).to include("Оригинальный и переведённый тексты равны")
  end

  it "is invalid card with original text and translated text incorrect" do
    invalid_card = Card.new(
      original_text: "MiT",
      translated_text: "WiTh")
    invalid_card.valid?
    expect(invalid_card.errors[:original_text] && invalid_card.errors[:translated_text]).to include("Слова только с большой буквы")
  end

end