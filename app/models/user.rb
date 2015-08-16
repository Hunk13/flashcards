class User < ActiveRecord::Base
  has_many :cards, through: :cards

  validates :email, :password, presence: true
end
