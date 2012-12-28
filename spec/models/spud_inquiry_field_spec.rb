require 'spec_helper'

describe SpudInquiryField do

  it {should belong_to(:spud_inquiry)}

  describe :validations do
    it "should save if validations pass" do
      p = FactoryGirl.build(:spud_inquiry_field)
      p.should be_valid
    end

    # it "should not be valid if inquiry is blank" do
    #   p = FactoryGirl.build(:spud_inquiry_field, :spud_inquiry => nil)
    #   p.should_not be_valid
    # end
  end
end
