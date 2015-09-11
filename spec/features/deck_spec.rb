require "rails_helper"

describe "Deck features" do
  let!(:deck) { FactoryGirl.create(:deck) }

  before(:each) { login("vasya@pupkin.ru", "12345") }

  it "titled deck added" do
    visit new_deck_path
    fill_in("deck_title", with: "Animals")
    click_on "Создать карточку"
    expect(deck.user.decks.count).to be (deck_count + 1)
  end

  it "untitled deck is no added" do
    deck_count = deck.user.decks.count
    visit new_deck_path
    fill_in("deck_title", with: "")
    click_on "Создать карточку"
    expect(deck.user.decks.count).to be (deck_count)
  end

  it "show cards in deck" do
    visit deck_path(deck)
    expect(current_path).to eq deck_path(deck)
  end

  it "update deck title" do
    visit edit_deck_path(deck)
    fill_in("deck_title", with: "TestDeck")
    click_on "Создать карточку"
    expect(deck.user.decks.first.title).to eq "TestDeck"
  end

  it "remove deck" do
    visit decks_path
    click_link "Destroy"
    expect(page).to have_content("Decks (0)")
  end
end