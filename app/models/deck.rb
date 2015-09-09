class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :users

  validates :title, presence: true
  validates_associated :users
end
