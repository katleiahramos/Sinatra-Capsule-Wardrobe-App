class CreateCapsules < ActiveRecord::Migration
  def change
    create_table :capsules do |t|
      t.string :name
      t.integer :user_id
    end

    add_column :pieces, :capsule_id, :integer


  end
end
