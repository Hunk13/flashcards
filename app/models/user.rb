class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  belongs_to :default_deck, class_name: "Deck", foreign_key: "default_deck_id"

  validates :name, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    email_format: { message: "has invalid format" }
  validates :password, length: { minimum: 3 },
                       presence: true,
                       confirmation: true,
                       on: :create
  validates :password_confirmation, presence: true,
                                    on: :create
end
