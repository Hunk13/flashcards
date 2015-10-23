class ChangeRepetitionsValueDefault < ActiveRecord::Migration
  def change
    change_column :cards, :repetitions, :integer, default:1
  end
end
