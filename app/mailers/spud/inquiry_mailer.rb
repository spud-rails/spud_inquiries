class Spud::InquiryMailer < ActionMailer::Base


  def inquiry_notification(inquiry)
  	@inquiry = inquiry
    @url = spud_admin_inquiry_url(:id => @inquiry.id)
  	# @url = "/spud/admin/inquiries/#{@inquiry.id}"
  	mail(:from =>Spud::Inquiries.from_address,:to => @inquiry.recipients.split(","), :subject => @inquiry.subject.blank? ? "No Subject" : @inquiry.subject)
  end

  def send_receipt(inquiry, form)
    @inquiry = inquiry
    @form = form

    mail(:from => Spud::Inquiries.from_address, :reply_to => Spud::Inquiries.reply_to.blank? ? Spud::Inquiries.from_address : Spud::Inquiries.reply_to, :to => @inquiry.email, :subject => @inquiry.subject.blank? ? "No Subject" : @inquiry.subject)
  end
end
