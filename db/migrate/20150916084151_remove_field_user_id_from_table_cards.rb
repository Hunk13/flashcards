class RemoveFieldUserIdFromTableCards < ActiveRecord::Migration
  def change
    remove_column :cards, :user_id, :integer
  end
end
