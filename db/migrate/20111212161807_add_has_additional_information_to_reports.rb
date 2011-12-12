class AddHasAdditionalInformationToReports < ActiveRecord::Migration
  def change
    add_column :reports, :has_additional_information, :boolean
  end
end
