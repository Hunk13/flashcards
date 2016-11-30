class Card < ActiveRecord::Base
  belongs_to :deck

  validate :original_not_equal_translated
  validates :review_date, :deck, presence: true
  validates :original_text, :translated_text, presence: true,
                                              length: { minimum: 2 },
                                              format: { with: /\A[A-ZА-Я]+[a-zа-я]+\z/,
                                                        message: I18n.t('model.big_words') }

  has_attached_file :picture, storage: :dropbox,
                              dropbox_credentials: {app_key: ENV['DROPBOX_APP_KEY'],
                                                    app_secret: ENV['DROPBOX_APP_SECRET'],
                                                    access_token: ENV['DROPBOX_ACCESS_TOKEN'],
                                                    access_token_secret: ENV['DROPBOX_ACCESS_TOKEN_SECRET'],
                                                    user_id: ENV['DROPBOX_USER_ID'],
                                                    access_type: 'app_folder'},
                              styles: { medium: '300x300>', thumb: '100x100>' },
                              default_url: '/images/:style/missing.png',
                              path: "/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment :picture, content_type: { content_type: 'image/jpeg' },
                                 size: { in: 0..1.megabytes }

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  after_initialize :set_date_after_review, if: :new_record?

  scope :expired, -> { where('review_date <= ?', DateTime.now) }
  scope :for_review, -> { expired.offset(rand(Card.expired.count)) }

  def check_translation(user_translation, seconds)
    typos = DamerauLevenshtein.distance(prepare_text(original_text),
                                        prepare_text(user_translation))
    update_params = SuperMemo2.repetition(original_text,
                                          typos,
                                          attempt,
                                          seconds,
                                          repetitions,
                                          e_factor)
    success = update_params.delete(:success)
    update_params[:attempt] = 0
    if success || attempt >= 2
      update(update_params)
    elsif attempt < 2
      self.increment!(:attempt)
    end
    { success: success, typos: typos }
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
end
