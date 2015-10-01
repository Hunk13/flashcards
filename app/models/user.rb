class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, through: :decks
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  belongs_to :default_deck, class_name: "Deck"

  before_save :set_locale, if: :new_record?
  validates :name, presence: true
  validates :locale, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    email_format: { message: I18n.t("model.invalid_mail") }
  validates :password, length: { minimum: 3 },
                       presence: true,
                       confirmation: true,
                       on: :create
  validates :password_confirmation, presence: true,
                                    on: :create
  def cards_for_review
    if default_deck.present?
      default_deck.cards.expired.for_review.first
    else
      cards.expired.for_review.first
    end
  end

  def self.notify_card_review
    User.includes(decks: :cards).each do |user|
      NotificationsMailer.pending_cards(user).deliver_later
    end
  end

  private

  def set_locale
    self.locale = I18n.default_locale
  end
end
