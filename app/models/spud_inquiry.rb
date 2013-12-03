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

  # def self.method_missing(method_sym, *arguments, &block)
  #   # the first argument is a Symbol, so you need to_s it if you want to pattern match
  #   if
  #     find($1.to_sym => arguments.first)
  #   else
  #     super
  #   end
  # end

  def self.respond_to?(method_sym, include_private = false)
    return true
  end
end
