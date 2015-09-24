require "rails_helper"

describe Card do
  let!(:valid_card) do
    create(:card, original_text: "Katze",
                  translated_text: "Cat",
                  review_date: 3.days.from_now,
                  picture: File.new(Rails.root + "spec/fixtures/files/Cat.jpg"),
                  deck: Deck.new(title: "Animals"))
  end

  let!(:review_card) do
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
      expect(invalid_card.errors[:original_text] &&
             invalid_card.errors[:translated_text]).to include("Слова только с большой буквы")
    end
  end

  context "counters" do
    it "should have correct successed_reviews_count" do
      valid_card.check_translation("Katze")
      expect(valid_card.correct_answers).to be >= 0
    end

    it "should have correct failed_reviews_count" do
      valid_card.check_translation("Katze")
      expect(valid_card.incorrect_answers).to be >= 0
    end
  end

  context "review date" do
    it "12 hours from now" do
      old_level = review_card.correct_answers
      review_card.check_translation("Katze")
      expect(old_level < review_card.correct_answers).to be true
    end

    it "12 hours from now" do
      old_level = review_card.correct_answers
      review_card.check_translation("Cat")
      expect(old_level < review_card.correct_answers).to be false
    end

    it "must down level card after 3 bad attempts" do
      card = create(:card, correct_answers: 0, incorrect_answers: 3)
      card.check_translation("Katze")
      expect(card.incorrect_answers).to be 3
    end

    it "must down level card after 3 bad attempts" do
      card = create(:card, correct_answers: 0, incorrect_answers: 2)
      card.check_translation("Dog")
      expect(card.incorrect_answers).to be 3
    end

    it "must down level card after 3 bad attempts" do
      card = create(:card, correct_answers: 0, incorrect_answers: 1)
      card.check_translation("Dog")
      expect(card.incorrect_answers).to be 2
    end

    it "must down level card after 3 bad attempts" do
      card = create(:card, correct_answers: 0, incorrect_answers: 0)
      card.check_translation("Dog")
      expect(card.incorrect_answers).to be 1
    end
  end
end
