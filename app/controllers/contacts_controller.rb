class ContactsController < ApplicationController
	caches_action :show,:if => Proc.new { |c| Spud::Inquiries.enable_action_caching }
	caches_action :thankyou,:if => Proc.new { |c| Spud::Inquiries.enable_action_caching }
	layout Spud::Inquiries.base_layout
	def show
		url_name = !params[:id].blank? ? params[:id] : Spud::Inquiries.default_contact_form
		@inquiry_form = SpudInquiryForm.where(:url_name => url_name).includes(:spud_inquiry_form_fields).first


		if @inquiry_form.blank?
			flash[:error] = "Contact Inquiry Form not found!"
			redirect_to root_url and return
		end
		@inquiry = SpudInquiry.new(:spud_inquiry_form_id => @inquiry_form.id)
		
	end

	def inquire
		if !params[:other_email].blank?
			flash[:error] = "You must be a robot! No robots allowed here!"
			redirect_to request.referer and return			
		end
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
		
		@inquiry_form.spud_inquiry_form_fields.order(:field_order).all.each do |field|
			val = params[:spud_inquiry][field.name]
			if field.required && val.blank?
				flash[:error] = "Not all required fields were entered"
				@inquiry.errors.add field.name,"is a required field"
				# redirect_to request.referer and return
			end
			@inquiry.spud_inquiry_fields.new(:name => field.name,:value => val)
		end
		# params[:spud_inquiry].each_pair do |key,value|
		# 	if key.to_s != "email" && key.to_s != "spud_inquiry_form_id"
		# 		@inquiry.spud_inquiry_fields.new(:name => key,:value => value)
		# 	end
		# end
		if !@inquiry.errors.empty?
			render :action => "show" and return
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
		render
	end	
end
