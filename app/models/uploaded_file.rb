class UploadedFile < ActiveRecord::Base
  attr_accessible :file_type, :report_id

  has_attached_file :document

  belongs_to :report
end
# == Schema Information
#
# Table name: uploaded_files
#
#  id         :integer         not null, primary key
#  file_type  :integer
#  report_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

