class Spud::Admin::InquiriesController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	add_breadcrumb "Inquiries", :spud_admin_media_path
	before_filter :load_inquiries,:only => [:edit,:update,:show,:destroy]	
	def index
		@page_thumbnail = "spud/admin/contacts_thumb.png"
		@page_name = "Inquiries"
		@inquiries = SpudInquiry.order("created_at DESC").paginate :page => params[:page]
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
