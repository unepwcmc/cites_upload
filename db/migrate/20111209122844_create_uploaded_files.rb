class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.integer :file_type
      t.integer :report_id

      t.timestamps
    end
  end
end
