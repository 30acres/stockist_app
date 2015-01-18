class AddSlugStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :slug, :string
  end
  
end
