class SpudInquiryFormField < ActiveRecord::Base
	belongs_to :spud_inquiry_form
	validates :name,:presence => true
	validates :field_type,:presence => true
	validates :spud_inquiry_form, :presence => true
	attr_accessible :name,:options,:default_value,:field_type,:spud_inquiry_form_id,:field_order,:required


	def options_list
		return [] if self.options.blank?
		self.options.split(/\,*?(".*?")\,*?/).map{|x| x=~/^".*"$/ ? x.gsub(/\"/,"") : x.split(',')}.flatten.select{|p| !p.strip.blank?}
	end



end
