class AddTradeGeckoToStockists < ActiveRecord::Migration
  def change
    add_column :stockists, :trade_gecko, :string
  end
end
