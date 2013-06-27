require 'spec_helper'

describe SpudInquiryFormField do

  it {should belong_to(:spud_inquiry_form)}

  describe :validations do
    it "should save if validations pass" do
      p = FactoryGirl.build(:spud_inquiry_form_field)
      p.should be_valid
    end

    it "should be invalid if name is blank" do
      p = FactoryGirl.build(:spud_inquiry_form_field, :name => nil)
      p.should_not be_valid
    end

    it "should be invalid if field_type is blank" do
      p = FactoryGirl.build(:spud_inquiry_form_field, :field_type => nil)
      p.should_not be_valid
    end

    # it "should not be valid if form is blank" do
    #   p = FactoryGirl.build(:spud_inquiry_form_field, :spud_inquiry_form => nil)
    #   p.should_not be_valid
    # end
  end

  describe :accessors do
    it "should fetch options list array" do
      p = FactoryGirl.build(:spud_inquiry_form_field,:options => "Test,\"Quoted , Option\"")
      p.options_list.should == ["Test","Quoted , Option"]
    end

  end
end
