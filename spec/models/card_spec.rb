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

  context "counters" do
    it "should have correct successed_reviews_count" do
      valid_card.check_translation("Katze", 0)
      expect(valid_card.correct_answers).to be >= 0
    end

    it "should have correct failed_reviews_count" do
      valid_card.check_translation("Katze", 0)
      expect(valid_card.incorrect_answers).to be >= 0
    end
  end

  describe "#rewiew" do
    let(:time_now) { Time.parse("Oct 08 2015") }

    before(:each) do
      DateTime.stub(:now).and_return(time_now)
      card.check_translation(card.original_text, 4)
    end

      context "first right review" do
        let(:card) { create(:card) }
        it { expect(card.review_date).to eq time_now + 1.day }
      end

      context "second right review" do
        let(:card) { create(:card, interval: 1, repetitions: 1) }
        it { expect(card.review_date).to eq time_now + 6.day }
      end

      context "third right review" do
        let(:card) { create(:card, interval: 6, repetitions: 2) }
        it { expect(card.review_date).to eq time_now + (2.5 * 6).day }
      end

      context "fourth right review" do
        let(:card) { create(:card, interval: 15, repetitions: 3) }
        it { expect(card.review_date).to eq time_now + (2.5 * 15).ceil.day }
      end

      context "fifth right review" do
        let(:card) { create(:card, interval: 37, repetitions: 4) }
        it { expect(card.review_date).to eq time_now + (2.5 * 37).ceil.day }
      end
  end
end
