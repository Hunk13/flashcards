class Card < ActiveRecord::Base
  validates :original, :translated, presence: true, length: { minimum: 3 }
end
