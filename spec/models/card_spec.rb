require "rails_helper"

describe Card do
  let!(:valid_card) do
    create(:card, original_text: "Katze",
                  translated_text: "Cat",
                  review_date: 3.days.from_now,
                  picture: File.new(Rails.root + "spec/fixtures/files/Cat.jpg"),
                  deck: Deck.new(title: "Animals"))
  end

  context "correctnes" do
    it "is valid card with original text, translated test and date review" do
      expect(valid_card).to be_valid
    end

    it "is invalid card without an original text" do
      invalid_card = Card.new(original_text: nil)
      invalid_card.valid?
      expect(invalid_card.errors[:original_text]).to include("не может быть пустым")
    end

    it "is invalid card without a translated text" do
      invalid_card = Card.new(translated_text: nil)
      invalid_card.valid?
      expect(invalid_card.errors[:translated_text]).to include("не может быть пустым")
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
      expect(invalid_card.errors[:original_text] &&
             invalid_card.errors[:translated_text]).to include("Слова должны быть с большой буквы")
    end
  end

  context "#rewiew" do
    let!(:card) { create(:card) }
    before(:each) { @answer_time = 0 }

    it "first right review" do
      repetition_backup = card.repetitions
      answer = "Katze"
      card.check_translation(answer, @answer_time)
      expect(card.repetitions).to eq (repetition_backup + 2)
    end

    it "second right review" do
      card.update_attributes(repetitions: 2)
      answer = "Katze"
      card.check_translation(answer, @answer_time)
      expect(card.repetitions).to eq 2
    end

    it "third right review" do
      card.update_attributes(interval: 4, repetitions: 3)
      answer = "Katze"
      card.check_translation(answer, @answer_time)
      expect(card.repetitions).to eq 2
    end

    it "fourth right review" do
      card.update_attributes(interval: 5, repetitions: 4)
      answer = "Katze"
      card.check_translation(answer, @answer_time)
      expect(card.repetitions).to eq 2
    end
  end
end
