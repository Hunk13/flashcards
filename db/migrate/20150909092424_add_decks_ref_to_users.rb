class AddDecksRefToUsers < ActiveRecord::Migration
  def change
    add_reference :decks, :users, index: true
  end
end
