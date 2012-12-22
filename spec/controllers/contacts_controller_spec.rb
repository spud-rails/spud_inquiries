require 'spec_helper'

describe ContactsController do
  before(:each) do
    Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
    end
  end

  describe :show do
    it "should return a form by url name" do
      form = FactoryGirl.create(:spud_inquiry_form)
      get :show, :use_route => :spud_inquiries, :id => form.url_name
      assigns(:inquiry_form).should == form
      assigns(:inquiry).should_not be_blank
    end

    it "should redirect to root if inquiry not found" do
      get :show, :use_route => :spud_inquiries, :id => 1234
      response.should redirect_to "/"
    end
  end

  describe :inquire do
    before(:each) do
      @form = FactoryGirl.create(:spud_inquiry_form)
      @field = FactoryGirl.create(:spud_inquiry_form_field,:spud_inquiry_form => @form,:name => "email",:field_type => '0', :required => true)
    end

    it "should fail if spam field assigned" do
      post :inquire, :use_route => :spud_inquiries,:spud_inquiry => {:spud_inquiry_form_id => @form.id}, :other_email => "test@spamcastle.com"
      flash[:error].should =~ /You must be a robot/i
    end

    it "should fail if inquiry not submitted" do
      post :inquire, :use_route => :spud_inquiries
      response.should redirect_to "/"
    end

    it "should fail if the inquiry form is invalid" do
      post :inquire, :use_route => :spud_inquiries,:spud_inquiry => {:spud_inquiry_form_id => @form.id + 2}
      response.should redirect_to "/"
    end

    it "should fail if required field is blank" do
      post :inquire, :use_route => :spud_inquiries,:spud_inquiry => {:spud_inquiry_form_id => @form.id}
      response.should be_success
      response.should_not redirect_to spud_inquiries.thankyou_url
    end

    # it "should succed if fields are valid" do
      # post :inquire, :use_route => :spud_inquiries,:spud_inquiry => {:spud_inquiry_form_id => @form.id, "email" => "test@test.com"}
      # assigns(:inquiry).should be_valid
      # response.should be_success
      # response.should redirect_to spud_inquiries.thankyou_url

    # end

  end

  describe :thankyou do
    it "should render successfully" do
      get :thankyou, :use_route => :spud_inquiries
      response.should be_success
    end
  end
end
