class SpudInquiry < ActiveRecord::Base

	has_many :spud_inquiry_fields, :dependent => :destroy
	belongs_to :spud_inquiry_form
  accepts_nested_attributes_for :spud_inquiry_fields, :reject_if => lambda { |a| a[:name].blank? }
  attr_accessible :spud_inquiry_form_id,:spud_inquiry_fields


  def email
    email_field = self.spud_inquiry_fields.where(:name => "email").first
    if !email_field.blank?
      return email_field.value
    end
    return "Unknown Sender"
  end

end
