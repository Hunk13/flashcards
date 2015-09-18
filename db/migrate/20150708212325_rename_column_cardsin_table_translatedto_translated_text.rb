class RenameColumnCardsinTableTranslatedtoTranslatedText < ActiveRecord::Migration
  def change
    rename_column :cards, :translated, :translated_text
  end
end
