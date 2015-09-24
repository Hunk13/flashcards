class Card < ActiveRecord::Base
  belongs_to :deck

  validate :original_not_equal_translated
  validates :review_date, :deck, presence: true
  validates :original_text, :translated_text, presence: true,
                                              length: { minimum: 2 },
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/,
                                                        message: "Слова только с большой буквы" }

  has_attached_file :picture, { styles: { medium: "360x360>", thumb: "100x100>" },
                                default_url: "/images/:style/missing.png" }.merge(PAPERCLIP_STORAGE_OPTIONS)
  validates_attachment :picture, content_type: { content_type: "image/jpeg" },
                                 size: { in: 0..1.megabytes }

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  before_save :set_date_after_review, on: :create

  scope :expired, -> { where("review_date <= ?", DateTime.now) }
  scope :for_review, -> { expired.offset(rand(Card.expired.count)) }

  def check_translation(user_translation)
    typos = distanse_of_words(original_text, user_translation)
    if typos <= 1
      process_correct_answer
      true
    else
      count_incorrect_answer
      false
    end
    { typos: typos, answer: typos <= 1 }
  end

  def process_correct_answer
    increment(:correct_answers) if correct_answers < 5
    update_review_date_if_correct
  end

  def count_incorrect_answer
    decrement(:correct_answers) if correct_answers > 0
    increment(:incorrect_answers) if incorrect_answers < 3
    update_review_date_if_incorrect
  end

  def update_review_date_if_correct
    offset = case correct_answers
             when 0
               0
             when 1
               12.hour
             when 2
               3.day
             when 3
               1.week
             when 4
               2.week
             else
               1.month
             end
    update_attributes(review_date: review_date + offset, incorrect_answers: 0)
  end

  def update_review_date_if_incorrect
    offset = case incorrect_answers
             when 0
               0
             when 1
               12.hour
             when 2
               3.day
             else
               1.week
             end
    update_attributes(review_date: review_date - offset)
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
    DateTime.now
  end

  def distanse_of_words(word1, word2)
    dl = DamerauLevenshtein
    dl.distance(prepare_text(word1), prepare_text(word2))
  end
end
