class ChangeAttemptCountsForCards < ActiveRecord::Migration
  def change
    change_column_default :cards, :correct_answers, 1
    rename_column :cards, :correct_answers, :attempt
    remove_column :cards, :incorrect_answers
  end
end
