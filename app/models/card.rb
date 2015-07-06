class Card < ActiveRecord::Base
  validates :original, :translated, presence: true, length: { minimum: 3 }
  validates :review, presence: true
end
