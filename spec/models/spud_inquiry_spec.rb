require 'spec_helper'

describe SpudInquiry do

  it {should have_many(:spud_inquiry_fields)}
  it {should belong_to(:spud_inquiry_form)}


  describe :accessors do
    it "should fetch email if field exists" do
      p = FactoryGirl.create(:spud_inquiry)
      email = FactoryGirl.create(:spud_inquiry_field, :spud_inquiry => p, :name => "email", :value => "test@spudcms.net")

      p.email.should == "test@spudcms.net"
    end

    it "should return unknown sender if email non-existent" do
      p = FactoryGirl.create(:spud_inquiry)
      p.email.should == "Unknown Sender"
    end
  end
end
