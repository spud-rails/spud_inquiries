class SpudInquiryField < ActiveRecord::Base
	belongs_to :spud_inquiry
	attr_accessible :name,:value,:spud_inquiry_id
end
