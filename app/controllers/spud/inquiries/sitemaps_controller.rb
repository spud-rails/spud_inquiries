class Spud::Inquiries::SitemapsController < Spud::ApplicationController
	respond_to :xml
  caches_page :show,:expires_in => 1.day
	def show
		@forms = SpudInquiryForm.all
    respond_with @forms
	end
end
