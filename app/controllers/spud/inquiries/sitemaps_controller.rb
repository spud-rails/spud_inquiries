class Spud::Inquiries::SitemapsController < Spud::ApplicationController
	caches_page :show,:expires_in => 1.day

	def show
		@forms = SpudInquiryForm.all
	end
end
