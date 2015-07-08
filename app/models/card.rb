class Card < ActiveRecord::Base
  validate :original_not_equal_translated
  validates :review_date, presence: true
  validates :original_text, :translated_text, presence: true, length: { minimum: 2 }, format: { with: /\A[A-Z]+[a-z]+\z/, message: "Слова только с большой буквы" }
 
  private
    def original_not_equal_translated
      if original_text.to_s == translated_text.to_s
        errors[:base] << "Оригинальный и переведённый тексты равны друг другу"
      end
    end
  end
