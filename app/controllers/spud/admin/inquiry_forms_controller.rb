class Spud::Admin::InquiryFormsController < Spud::Admin::ApplicationController
	belongs_to_spud_app :inquiries, :title => "Inquiry Forms"
	layout 'spud/admin/detail'
	before_filter :load_form,:only => [:edit,:update,:show,:destroy]

	add_breadcrumb "Inquiries", :spud_admin_inquiries_path
	add_breadcrumb "Forms", :spud_admin_inquiry_forms_path
	add_breadcrumb "New", '',:only =>  [:new, :create]
	add_breadcrumb "Edit", '',:only => [:edit, :update]

	def index
		@inquiry_forms = SpudInquiryForm.order(:name).paginate :page => params[:page]
		respond_with @inquiry_forms
	end

	def new
		@inquiry_form = SpudInquiryForm.new
		respond_with @inquiry_form
	end

	def create
		@inquiry_form = SpudInquiryForm.new(inquiry_form_params)
		flash[:notice] = "Form saved successfully!" if @inquiry_form.save

		respond_with @inquiry_form,:location => spud_admin_inquiry_forms_url
	end

	def edit
		respond_with @inquiry_form
	end

	def update
		flash[:notice] = "Form saved successfully!" if @inquiry_form.update_attributes(inquiry_form_params)
		if Spud::Inquiries.enable_action_caching
			Rails.cache.clear
		end
		respond_with @inquiry_form, :location => spud_admin_inquiry_forms_url
	end

	def destroy
		flash[:notice] = "Inquiry form removed!" if @inquiry_form.destroy
		if Spud::Inquiries.enable_action_caching
			Rails.cache.clear
		end
		respond_with @inquiry_form,:location => spud_admin_inquiry_forms_url
	end
private
	def load_form
		@inquiry_form = SpudInquiryForm.where(:id => params[:id]).first
		if @inquiry_form.blank?
			flash[:error] = "Inquiry Form not found!"
			redirect_to spud_admin_inquiry_forms_url() and return
		end
	end

	def inquiry_form_params
		params.require(:spud_inquiry_form).permit(:name,:url_name,:recipients,:content, :receipt_content, :subject,{:spud_inquiry_form_fields_attributes => [:id,:name,:options,:default_value,:field_type,:spud_inquiry_form_id,:field_order,:required, :placeholder, :class_name, :validation_rule, :validation_error_message, :_destroy]}, :created_at, :updated_at, :thank_you_content, :submit_title)
	end
end
