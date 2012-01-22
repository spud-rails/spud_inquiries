class ContactsController < ApplicationController
	def show
		url_name = !params[:id].blank? ? params[:id] : Spud::Inquiries.default_contact_form
		@inquiry_form = SpudInquiryForm.where(:name => url_name).includes(:spud_inquiry_form_fields).first
		if @inquiry_form.blank?
			flash[:error] = "Contact Inquiry Form not found!"
			redirect_to root_url and return
		end
		render :layout => Spud::Inquiries.base_layout
	end

	def inquire
		unless params[:spud_inquiry]
			flash[:error] = "Inquiry Not Found!"
			redirect_to request.referer and return
		end

		@inquiry = SpudInquiry.new(:email => params[:spud_inquiry][:email])
		params[:spud_inquiry].each_pair do |key,value|
			if key != :email
				@inquiry.spud_inquiry_fields.new(:name => key,:value => value)

			end
		end
		if @inquiry.save
			flash[:notice] = "Your inquiry was received!"
		else
			flash[:error] = "Whoops! Something went wrong. Please try again!"
		end
		redirect_to request.referer and return

	end
end
