class Spud::Admin::InquiriesController < Spud::Admin::ApplicationController
	layout 'spud/admin/detail'
	belongs_to_spud_app :inquiries
	add_breadcrumb "Inquiries", :spud_admin_inquiries_path
	before_filter :load_inquiries,:only => [:edit,:update,:show,:destroy]	
	def index
		@inquiries = SpudInquiry.order("created_at DESC").includes(:spud_inquiry_form).paginate :page => params[:page]
		respond_with @inquiries
	end

	def show
		add_breadcrumb "#{@inquiry.email}", :spud_admin_inquiry_path
		respond_with @inquiry
	end

	def destroy
		status = 500
		if @inquiry.destroy
			status = 200
		end
		respond_with @inquiry do |format|
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
