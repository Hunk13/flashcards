
class Card < ActiveRecord::Base
  validate :original_not_equal_translated, :original_translated_up_down_first_letter
  validates :review, presence: true
  validates :original, :translated, presence: true, length: { minimum: 2 }, format: { with: /\A[A-Z]+[a-z]+\z/, message: "Слова только с большой буквы" }

  private
    def original_not_equal_translated
      if original.to_s == translated.to_s
        errors[:base] << "Оригинальный и переведённый тексты равны друг другу"
      end
    end

    def original_translated_up_down_first_letter
      if original.capitalize.to_s == translated.to_s
        errors[:base] << "Проверьте ввод слов"
    end
  end
end