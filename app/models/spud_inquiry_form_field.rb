class SpudInquiryFormField < ActiveRecord::Base
	belongs_to :spud_inquiry_form, :touch => true
	validates :name,:presence => true
	validates :field_type,:presence => true

	# validates :spud_inquiry_form_id, :presence => true
	# attr_accessible :name,:options,:default_value,:field_type,:spud_inquiry_form_id,:field_order,:required, :placeholder, :class_name

	before_save :update_field_name

	def options_list
		return [] if self.options.blank?
		self.options.split(/\,*?(".*?")\,*?/).map{|x| x=~/^".*"$/ ? x.gsub(/\"/,"") : x.split(',')}.flatten.select{|p| !p.strip.blank?}
	end

	def update_field_name
		if self.name.blank?
			return
		end
		self.field_name = self.name.parameterize.underscore
	end
end
