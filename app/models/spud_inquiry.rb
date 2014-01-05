class SpudInquiry < ActiveRecord::Base

	has_many :spud_inquiry_fields, :dependent => :destroy
	belongs_to :spud_inquiry_form
  accepts_nested_attributes_for :spud_inquiry_fields, :reject_if => lambda { |a| a[:name].blank? }
  # attr_accessible :spud_inquiry_form_id,:spud_inquiry_fields


  def email
    email_field = self.spud_inquiry_fields.where(:name => "email").first
    if !email_field.blank?
      return email_field.value
    end
    return "Unknown Sender"
  end


  # If a property is not defined here we want to check the dynamic fields list
  def method_missing(sym, *args)
    inquiry_field = self.spud_inquiry_fields.select{ |inquiry_field| inquiry_field.field_name == sym.to_s}
    if inquiry_field.any?
      return inquiry_field[0].value
    end
    super
  end

  def respond_to?(sym, include_all=false)
    default_responds = super
    if !default_responds
      inquiry_field = self.spud_inquiry_fields.select{ |inquiry_field| inquiry_field.field_name == sym.to_s}
      if inquiry_field.any?
        return true
      end
    end
    return default_responds
  end

end
