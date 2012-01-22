class Spud::Admin::InquiriesController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Inquiries", :spud_admin_inquiries_path
	before_filter :load_inquiries,:only => [:edit,:update,:show,:destroy]	
	def index
		@page_thumbnail = "spud/admin/contacts_thumb.png"
		@page_name = "Inquiries"
		@inquiries = SpudInquiry.order("created_at DESC").paginate :page => params[:page]
	end

	def show
		@page_thumbnail = "spud/admin/contacts_thumb.png"
		@page_name = "Inquiry"
		add_breadcrumb "#{@inquiry.email}", :spud_admin_inquiry_path
	end

	def destroy
		status = 500
		if @inquiry.destroy
			status = 200
		end
		respond_to do |format|
			format.js { render :status => status,:text => nil}
			format.html {
				flash[:error] = "Error removing inquiry!" if status == 500
				flash[:notice] = "Inquiry removed!" if status == 200
				redirect_to spud_admin_inquiries_path and return
			}
		end
	end
private
	def load_inquiries
		@inquiry = SpudInquiry.where(:id => params[:id]).first
		if @inquiry.blank?
			flash[:error] = "Inquiry not found!"
			redirect_to spud_admin_inquiries_path and return
		end
	end
end
