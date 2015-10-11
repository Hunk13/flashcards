class Card < ActiveRecord::Base
  belongs_to :deck

  validate :original_not_equal_translated
  validates :review_date, :deck, presence: true
  validates :original_text, :translated_text, presence: true,
                                              length: { minimum: 2 },
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/,
                                                        message: I18n.t("model.big_words") }

  has_attached_file :picture, { styles: { medium: "360x360>", thumb: "100x100>" },
                                default_url: "/images/:style/missing.png" }.merge(PAPERCLIP_STORAGE_OPTIONS)
  validates_attachment :picture, content_type: { content_type: "image/jpeg" },
                                 size: { in: 0..1.megabytes }

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  after_initialize :set_date_after_review, if: :new_record?

  scope :expired, -> { where("review_date <= ?", DateTime.now) }
  scope :for_review, -> { expired.offset(rand(Card.expired.count)) }

  def check_translation(user_translation, quality)
    typos = distanse_of_words(original_text, user_translation)
    answer = typos <= 1
    # 1 - maximum Levenshtein distance
    update_review_date(answer ? quality : 0)
    { typos: typos, answer: answer }
  end

  def update_review_date(quality)
    repetition = SuperMemo2.repetition(e_factor, interval, quality, repetitions)
    repetition[:review_date] = Time.zone.now + repetition[:interval]
    update_attributes(repetition)
  end

  private

  def original_not_equal_translated
    if prepare_text(original_text) == prepare_text(translated_text)
      errors.add(:original_text, I18n.t("model.equal"))
    end
  end

  def prepare_text(string)
    string.to_s.mb_chars.downcase.strip
  end

  def set_date_after_review
    self.review_date = Time.zone.now
  end

  def distanse_of_words(word1, word2)
    DamerauLevenshtein.distance(prepare_text(word1), prepare_text(word2))
  end
end
