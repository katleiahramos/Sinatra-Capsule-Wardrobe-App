class RemoveSizeFromPieces < ActiveRecord::Migration
  def change
    remove_column :pieces, :size
  end
end
