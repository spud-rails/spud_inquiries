class Spud::Admin::InquiryFormsController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	belongs_to_spud_app :inquiries, :title => "Inquiry Forms"
	cache_sweeper :inquiry_sweeper, :only => [:update,:destroy,:create]
	add_breadcrumb "Inquiries", {:controller => "/spud/admin/inquiries", :action => :index}
	add_breadcrumb "Forms", {:action => :index}
	add_breadcrumb "New", '',:only =>  [:new, :create]
	add_breadcrumb "Edit", '',:only => [:edit, :update]
	before_filter :load_form,:only => [:edit,:update,:show,:destroy]
	def index

		@inquiry_forms = SpudInquiryForm.order(:name).paginate :page => params[:page]
		respond_with @inquiry_forms
	end

	def new
		@inquiry_form = SpudInquiryForm.new
		respond_with @inquiry_form
	end

	def create
		@inquiry_form = SpudInquiryForm.new(params[:spud_inquiry_form])
		flash[:notice] = "Form saved successfully!" if @inquiry_form.save

		respond_with @inquiry_form,:location => spud_admin_inquiry_forms_url
	end

	def edit
		respond_with @inquiry_form
	end

	def update
		flash[:notice] = "Form saved successfully!" if @inquiry_form.update_attributes(params[:spud_inquiry_form])
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
end
