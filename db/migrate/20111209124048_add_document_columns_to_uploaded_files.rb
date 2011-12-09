class AddDocumentColumnsToUploadedFiles < ActiveRecord::Migration
  def change
    add_column :uploaded_files, :document_file_name,    :string
    add_column :uploaded_files, :document_content_type, :string
    add_column :uploaded_files, :document_file_size,    :integer
    add_column :uploaded_files, :document_updated_at,   :datetime
  end
end
