class AddHasExportsAndHasImportsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :has_exports, :boolean
    add_column :reports, :has_imports, :boolean
  end
end
