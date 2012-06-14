class RemoveContactDetailsAndCountryFromReports < ActiveRecord::Migration
  def up
    remove_column :reports, :contact_details
    remove_column :reports, :country
  end

  def down
    add_column :reports, :country, :string
    add_column :reports, :contact_details, :string
  end
end
