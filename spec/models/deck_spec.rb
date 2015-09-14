require 'rails_helper'

describe Deck do
  before(:each) do
    @deck = FactoryGirl.create(:deck)
  end
  it "create valid deck" do
    expect(@deck).to be_valid
  end

  it "create empty deck" do
    invalid_deck = Deck.new(title: nil)
    invalid_deck.valid?
    expect(invalid_deck.errors[:title]).to include("can't be blank")
  end
end