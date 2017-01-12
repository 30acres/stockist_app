class AddDataToStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :data, :json
  end
end
