class Card < ActiveRecord::Base
  validate :original_not_equal_translated
  validates :review_date, presence: true
  validates :original_text, :translated_text, presence: true, 
                                              length: { minimum: 2 }, 
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/, message: "Слова только с большой буквы" }
  before_save :set_date_after_review, on: :create

  scope :for_review, -> {where("review_date <= ?", DateTime.now).order("RANDOM()")}

  def set_date_after_review
    review_date = DateTime.now + 3.days
  end

  def update_translation(user_translation)
    if translated_text.downcase.to_s == user_translation.downcase.to_s
      update_attribute(review_date: Date.today + 3.days)
    end
  end

  private
    def original_not_equal_translated
      if original_text.to_s == translated_text.to_s
        errors.add(original_text, "Оригинальный и переведённый тексты равны друг другу")
      end
    end
  end