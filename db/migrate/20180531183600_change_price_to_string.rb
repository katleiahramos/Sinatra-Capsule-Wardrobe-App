class ChangePriceToString < ActiveRecord::Migration
  def change
    change_column :pieces, :price, :string
  end
end
