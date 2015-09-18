class AddDecksRefToUsers < ActiveRecord::Migration
  def change
    add_reference :decks, :users, index: true, foreign_key: true
  end
end
