class Report < ActiveRecord::Base
  attr_accessible :country, :year, :basis, :contact_details

  include EnumerateIt
  has_enumeration_for :basis, :with => CompilationBasis, :create_helpers => true

  has_many :uploaded_files
end
# == Schema Information
#
# Table name: reports
#
#  id              :integer         not null, primary key
#  country         :string(255)
#  year            :integer
#  basis           :integer
#  contact_details :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

