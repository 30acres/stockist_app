class AddNamesToStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :first_name, :string
    add_column :stockists, :last_name, :string
  end
end
