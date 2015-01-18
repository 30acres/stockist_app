class AddCountryIdToStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :country_id, :integer
  end
end
