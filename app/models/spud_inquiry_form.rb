class SpudInquiryForm < ActiveRecord::Base
	has_many :spud_inquiry_form_fields,:dependent => :destroy,:order => "field_order ASC"
    accepts_nested_attributes_for :spud_inquiry_form_fields, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

	validates :name,:presence => true,:uniqueness => true
end
