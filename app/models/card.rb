class Card < ActiveRecord::Base
	validates :original, presence: true, length: { minimum: 3}
	validates :translated, presence: true, length: { minimum: 3}
end
