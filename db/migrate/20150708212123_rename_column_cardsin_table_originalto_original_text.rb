class RenameColumnCardsinTableOriginaltoOriginalText < ActiveRecord::Migration
  def change
    rename_column :cards, :original, :original_text
  end
end
