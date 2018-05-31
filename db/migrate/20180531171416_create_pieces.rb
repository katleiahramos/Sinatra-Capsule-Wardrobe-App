class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :size
      t.integer :price
      t.string :description
      t.integer :user_id
      t.integer :category_id
    end
  end
end
