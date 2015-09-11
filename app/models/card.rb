class Card < ActiveRecord::Base
  belongs_to :deck

  validates_presence_of :deck
  validate :original_not_equal_translated
  validates :review_date, presence: true
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
