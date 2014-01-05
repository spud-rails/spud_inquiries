class SpudInquiryForm < ActiveRecord::Base
	has_many :spud_inquiries, :dependent => :nullify
	has_many :spud_inquiry_form_fields, -> { order :field_order},:dependent => :destroy

  accepts_nested_attributes_for :spud_inquiry_form_fields, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

	validates :name,:presence => true,:uniqueness => true
	validates :url_name,:presence => true, :uniqueness => true
	before_validation :generate_url_name
	after_save :expire_cache
	after_destroy :expire_cache
	# attr_accessible :name,:url_name,:recipients,:content,:subject,:spud_inquiry_form_fields_attributes, :created_at, :updated_at, :thank_you_content, :submit_title

  def generate_url_name
    if !self.name.blank?
      self.url_name = self.name.gsub(/[^a-zA-Z0-9\ ]/," ").gsub(/\ \ +/," ").gsub(/\ /,"-").downcase
    end
  end

  def expire_cache
  	if !defined?(SpudPageLiquidTag)
  		return
  	end
    # Now Time to Update Parent Entries
    old_name = self.name_was
    values = [self.name]
    values << old_name if !old_name.blank?


    SpudPageLiquidTag.where(:tag_name => "inquiry",:value => values).includes(:attachment).each do |tag|
      partial = tag.touch
    end
  end
end
