class UploadedFile < ActiveRecord::Base
  attr_accessible :file_type, :report_id, :document

  include EnumerateIt
  has_enumeration_for :file_type, :with => FileTypes, :create_helpers => true

  has_attached_file :document,
    :storage => :s3,
    :s3_credentials => Rails.application.secrets.s3_storage
  validates_attachment_size :document, :less_than => 10.megabytes if :document
  do_not_validate_attachment_file_type :document
  belongs_to :report, :touch => true
end
# == Schema Information
#
# Table name: uploaded_files
#
#  id                    :integer         not null, primary key
#  file_type             :integer
#  report_id             :integer
#  created_at            :datetime
#  updated_at            :datetime
#  document_file_name    :string(255)
#  document_content_type :string(255)
#  document_file_size    :integer
#  document_updated_at   :datetime
#

