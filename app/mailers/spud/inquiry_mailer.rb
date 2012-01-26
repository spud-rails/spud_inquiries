class Spud::InquiryMailer < ActionMailer::Base
  

  def inquiry_notification(inquiry)
  	@inquiry = inquiry
  	@url = "/spud/admin/inquiries/#{@inquiry.id}"
  	mail(:from =>Spud::Inquiries.from_address,:to => @inquiry.recipients.split(","), :subject => @inquiry.subject.blank? ? "No Subject" : @inquiry.subject)
  end
end
