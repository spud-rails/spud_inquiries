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
		@inquiry_form = SpudInquiryForm.find(params[:spud_inquiry][:spud_inquiry_form_id])
		if @inquiry_form.blank?
			flash[:error] = "Form Not Found!"
			redirect_to request.referer and return 
		end
		@inquiry = SpudInquiry.new(:email => params[:spud_inquiry][:email],:spud_inquiry_form_id => params[:spud_inquiry][:spud_inquiry_form_id])
		
		@inquiry.recipients = @inquiry_form.recipients
		@inquiry.subject = @inquiry_form.subject
		
		params[:spud_inquiry].each_pair do |key,value|
			if key.to_s != "email" && key.to_s != "spud_inquiry_form_id"
				@inquiry.spud_inquiry_fields.new(:name => key,:value => value)
			end
		end
		if @inquiry.save
			flash[:notice] = "Your inquiry was received!"
			if !@inquiry.recipients.blank?
				Spud::InquiryMailer.inquiry_notification(@inquiry).deliver
			end
		else
			flash[:error] = "Whoops! Something went wrong. Please try again!"
		end
		redirect_to contact_thankyou_url
	end

	def thankyou
		render :layout => Spud::Inquiries.base_layout
	end	
end
