class ContactsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	layout Spud::Inquiries.base_layout
	respond_to :html,:js
	def show
		url_name      = !params[:id].blank? ? params[:id] : Spud::Inquiries.default_contact_form
		@inquiry_form = SpudInquiryForm.where(:url_name => url_name).includes(:spud_inquiry_form_fields).first

		if @inquiry_form.blank?
			flash[:error] = "Contact Inquiry Form not found!"
			redirect_to "/" and return
		end
		@spud_inquiry = SpudInquiry.new(:spud_inquiry_form_id => @inquiry_form.id)
	end

	def inquire
		if !params[:other_email].blank?
			flash[:error] = "You must be a robot! No robots allowed here!"
			redirect_to request.referer || "/" and return
		end
		unless params[:spud_inquiry]
			flash[:error] = "Inquiry Not Found!"
			redirect_to request.referer || "/" and return
		end
		@inquiry_form = SpudInquiryForm.where(:id => params[:spud_inquiry][:spud_inquiry_form_id]).first
		if @inquiry_form.blank?
			flash[:error] = "Form Not Found!"
			redirect_to request.referer || "/" and return
		end
		@spud_inquiry = SpudInquiry.new(:spud_inquiry_form_id => params[:spud_inquiry][:spud_inquiry_form_id])

		@spud_inquiry.recipients = @inquiry_form.recipients
		@spud_inquiry.subject = @inquiry_form.subject

		@inquiry_form.spud_inquiry_form_fields.order(:field_order).each do |field|
			val = params[:spud_inquiry][field.field_name]
			if field.required && val.blank?
				flash[:error] = "Not all required fields were entered"
				@spud_inquiry.errors.add field.field_name,"is a required field"
			end

			if field.validation_rule
				if Regexp.new(field.validation_rule).match(val) == nil
					flash[:error] = "Not all fields were valid"
					@spud_inquiry.errors.add field.field_name, field.validation_error_message
				end
			end
			@spud_inquiry.spud_inquiry_fields.new(:name => field.name, :field_name => field.field_name,:value => val)
		end

		if !@spud_inquiry.errors.empty?
			respond_to do |format|
				format.html {render :action => "show"}
				format.js { render "show.js.erb"}
			end
			return
		end
		if @spud_inquiry.save
			flash[:notice] = "Your inquiry was received!"
			if !@spud_inquiry.recipients.blank?
				Spud::InquiryMailer.inquiry_notification(@spud_inquiry).deliver
			end
		else
			flash[:error] = "Whoops! Something went wrong. Please try again!"
			respond_to do |format|
				format.html {render :action => "show"}
				format.js { render "show.js.erb"}
			end
			return
		end
		respond_to do |format|
			format.html { redirect_to contact_thankyou_url }
			format.js { render "thankyou.js.erb"}
		end

	end



	def thankyou
		render
	end
end
