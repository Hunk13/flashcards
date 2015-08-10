class Card < ActiveRecord::Base
  validate :original_not_equal_translated
  validates :review_date, presence: true
  validates :original_text, :translated_text, presence: true, 
                                              length: { minimum: 2 }, 
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/, message: "Слова только с большой буквы" }
  before_save :set_date_after_review, on: :create

  scope :expired, -> { where("review_date <= ?", DateTime.now) }
  scope :for_review, -> { expired.offset(rand(Card.expired.count)) }

  def update_translation_date(user_translation)
    if conversion_words(original_text) == conversion_words(user_translation)
      update_attribute(:review_date, set_date_after_review)
    end
  end

  private

  def original_not_equal_translated
    if conversion_words(original_text) == conversion_words(translated_text)
      errors.add(:original_text, "Оригинальный и переведённый тексты равны")
    end
  end

  def conversion_words(string)
    string.mb_chars.downcase
  end

  def set_date_after_review
    DateTime.now + 3.days
  end
end
