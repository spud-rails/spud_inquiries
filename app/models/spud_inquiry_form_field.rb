class SpudInquiryFormField < ActiveRecord::Base
	belongs_to :spud_inquiry_form
	validates :name,:presence => true
	validates :field_type,:presence => true
	
end
