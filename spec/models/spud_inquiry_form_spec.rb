require 'spec_helper'

describe SpudInquiryForm do

  it {should have_many(:spud_inquiries)}
  it {should have_many(:spud_inquiry_form_fields)}

  describe :validations do
    it "should be invalid if name is blank" do
      p = FactoryGirl.build(:spud_inquiry_form, :name => nil)
      p.should_not be_valid
    end

    it "should require a unique name" do
      p = FactoryGirl.create(:spud_inquiry_form, :name => "Test")
      p2 = FactoryGirl.build(:spud_inquiry_form, :name => "Test")
      p2.should_not be_valid
    end
  end

  describe :hooks do
    it "should generate a url_name before validating" do
      p = FactoryGirl.build(:spud_inquiry_form, :name => "Contact Us")
      p.should be_valid
      p.url_name.should == p.name.gsub(/[^a-zA-Z0-9\ ]/," ").gsub(/\ \ +/," ").gsub(/\ /,"-").downcase
    end
  end
end
