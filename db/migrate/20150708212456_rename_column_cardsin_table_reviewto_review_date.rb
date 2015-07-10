# -*- encoding : utf-8 -*-
class RenameColumnCardsinTableReviewtoReviewDate < ActiveRecord::Migration
  def change
    rename_column :cards, :review, :review_date
  end
end
