class SpudInquiry < ActiveRecord::Base

	has_many :spud_inquiry_fields
	belongs_to :spud_inquiry_form
    accepts_nested_attributes_for :spud_inquiry_fields, :reject_if => lambda { |a| a[:name].blank? }
    validates :email,:presence => true

    attr_accessible :spud_inquiry_form_id,:email,:spud_inquiry_fields
end
