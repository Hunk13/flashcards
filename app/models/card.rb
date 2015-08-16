class Card < ActiveRecord::Base
  validate :original_not_equal_translated
  validates :review_date, :user_id, presence: true
  validates :original_text, :translated_text, presence: true, 
                                              length: { minimum: 2 }, 
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/, message: "Слова только с большой буквы" }
  before_save :set_date_after_review, on: :create

  scope :expired, -> { where("review_date <= ?", DateTime.now) }
  scope :for_review, -> { expired.offset(rand(Card.expired.count)) }

  belongs_to :user, foreign_key: "user_id"

  def update_translation_date(user_translation)
    if prepare_text(original_text) == prepare_text(user_translation)
      update_attributes(review_date: set_date_after_review)
    end
  end

  private

  def original_not_equal_translated
    if prepare_text(original_text) == prepare_text(translated_text)
      errors.add(:original_text, "Оригинальный и переведённый тексты равны")
    end
  end

  def prepare_text(string)
    string.to_s.mb_chars.downcase.strip
  end

  def set_date_after_review
    DateTime.now + 3.days
  end
end
