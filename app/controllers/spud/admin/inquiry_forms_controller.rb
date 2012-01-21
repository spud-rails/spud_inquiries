class Spud::Admin::InquiryFormsController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Inquiries", :spud_admin_inquiries_path
	add_breadcrumb "Forms", :spud_admin_inquiry_forms_path
	before_filter :load_form,:only => [:edit,:update,:show,:destroy]	
	def index
		@page_thumbnail = "spud/admin/contacts_thumb.png"
		@page_name = "Inquiry Forms"
		@inquiry_forms = SpudInquiryForm.order(:name).paginate :page => params[:page]
	end

	def new
		@inquiry_form = SpudInquiryForm.new
	end

	def create
		@inquiry_form = SpudInquiryForm.new(params[:spud_inquiry_form])
		if @inquiry_form.save
			flash[:notice] = "Form saved successfully!"
			redirect_to spud_admin_inquiry_forms_url and return
		else
			flash[:error] = "Error saving form!"
			@error_object_name = "inquiry_form"
			render :action => "new"
		end
	end

	def edit

	end

	def update
		if @inquiry_form.update_attributes(params[:spud_inquiry_form])
			flash[:notice] = "Form saved successfully!"
			redirect_to spud_admin_inquiry_forms_url and return
		else
			flash[:error] = "Error saving form!"
			@error_object_name = "inquiry_form"
			render :action => "edit"
		end
	end

	def destroy
		status = 500
		if @inquiry_form.destroy
			status = 200
		end

		respond_to do |format|
			format.js { render :text => nil, :status => status}
			format.html {
				flash[:error] = "Error removing form" if status == 500
				flash[:notice] = "Form successfully removed!" if status == 200
				redirect_to spud_admin_inquiry_forms_url
			}
		end
	end
private
	def load_form
		@inquiry_form = SpudInquiryForm.where(:id => params[:id]).first
		if @inquiry_form.blank?
			flash[:error] = "Inquiry Form not found!"
			redirect_to spud_admin_inquiry_forms_url() and return
		end
	end
end
