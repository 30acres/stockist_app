class AddCustomlToStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :customlongitude, :float
    add_column :stockists, :customlatitude, :float
  end
end
