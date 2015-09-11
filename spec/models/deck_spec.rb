require 'rails_helper'

describe Deck do
  let(:deck) { FactoryGirl.create(:deck, title: "MyDeck") }

  it "valid deck" do
    expect(deck.title).to eq("MyDeck")
  end
end
