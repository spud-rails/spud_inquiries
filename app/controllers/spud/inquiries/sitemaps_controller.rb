class Spud::Inquiries::SitemapsController < Spud::ApplicationController
	respond_to :xml
	def show
		@forms = SpudInquiryForm.all
    respond_with @forms
	end
end
