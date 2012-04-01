class SpudInquiryFormField < ActiveRecord::Base
	belongs_to :spud_inquiry_form
	validates :name,:presence => true
	validates :field_type,:presence => true
	attr_accessible :name,:options,:default_value,:field_type,:spud_inquiry_form_id
	
end
