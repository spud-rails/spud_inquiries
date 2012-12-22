class SpudInquiryForm < ActiveRecord::Base
	has_many :spud_inquiries, :dependent => :nullify
	has_many :spud_inquiry_form_fields,:dependent => :destroy,:order => "field_order ASC"

  accepts_nested_attributes_for :spud_inquiry_form_fields, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

	validates :name,:presence => true,:uniqueness => true
	validates :url_name,:presence => true, :uniqueness => true
	before_validation :generate_url_name
	attr_accessible :name,:url_name,:recipients,:content,:subject,:spud_inquiry_form_fields_attributes

  def generate_url_name
    if !self.name.blank?
      self.url_name = self.name.gsub(/[^a-zA-Z0-9\ ]/," ").gsub(/\ \ +/," ").gsub(/\ /,"-").downcase
    end
  end
end
