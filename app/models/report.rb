class Report < ActiveRecord::Base
  attr_accessible :year, :basis, :has_exports, :has_imports, :uploaded_exports_attributes,
                  :uploaded_imports_attributes, :has_additional_information, :uploaded_additional_information_attributes, :user_id,
                  :no_trade_exports, :no_trade_imports

  include EnumerateIt
  has_enumeration_for :basis, :with => CompilationBasis, :create_helpers => true

  belongs_to :user
  has_many :uploaded_exports, :class_name => "UploadedFile", :conditions => "file_type = #{FileTypes::EXPORT}"
  has_many :uploaded_imports, :class_name => "UploadedFile", :conditions => "file_type = #{FileTypes::IMPORT}"
  has_many :uploaded_additional_information, :class_name => "UploadedFile", :conditions => "file_type = #{FileTypes::ADDITIONAL_INFORMATION}"
  accepts_nested_attributes_for :uploaded_exports, :allow_destroy => true, :reject_if => proc {|attributes| attributes['document'].blank?}
  accepts_nested_attributes_for :uploaded_imports, :allow_destroy => true, :reject_if => proc {|attributes| attributes['document'].blank?}
  accepts_nested_attributes_for :uploaded_additional_information, :allow_destroy => true, :reject_if => proc {|attributes| attributes['document'].blank?}
end
# == Schema Information
#
# Table name: reports
#
#  id                         :integer         not null, primary key
#  country                    :string(255)
#  year                       :integer
#  basis                      :integer
#  contact_details            :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  has_exports                :boolean
#  has_imports                :boolean
#  has_additional_information :boolean
#

