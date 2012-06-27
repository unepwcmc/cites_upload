class AddNoTradeExportsAndNoTradeImportsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :no_trade_exports, :boolean
    add_column :reports, :no_trade_imports, :boolean
  end
end
