class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :country
      t.integer :year
      t.integer :basis
      t.string :contact_details

      t.timestamps
    end
  end
end
