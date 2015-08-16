class UsersIdCard < ActiveRecord::Migration
  def change
    add_column :cards, :user_id, :integer, null: false
  end
end
