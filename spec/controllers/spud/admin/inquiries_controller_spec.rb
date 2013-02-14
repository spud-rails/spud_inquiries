require 'spec_helper'

describe Spud::Admin::InquiriesController do
  before(:each) do
    activate_authlogic
    u = SpudUser.new(:login => "testuser",:email => "test@testuser.com",:password => "test",:password_confirmation => "test")
    u.super_admin = true
    u.save
    @user = SpudUserSession.create(u)
    Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
    end
  end

  describe :index do
    it "should return an array of menus" do
      2.times {|x|  s = FactoryGirl.create(:spud_inquiry)}
      get :index
      assigns(:inquiries).count.should be > 1
    end
  end

  describe :show do
    it "should return a preview of an inquiry" do
      s = FactoryGirl.create(:spud_inquiry)
      get :show, :id => s.id
      assigns(:inquiry).should == s
    end

    it "should redirect to index if inquiry not found" do
      get :show, :id => 1234
      response.should redirect_to spud_admin_inquiries_url
    end
  end

  describe :destroy do
    it "should destroy the menu" do
      inquiry = FactoryGirl.create(:spud_inquiry)
      lambda {
        delete :destroy, :id => inquiry.id
      }.should change(SpudInquiry,:count).by(-1)
      response.should be_redirect
    end

    it "should not destroy the menu with a wrong id" do
      inquiry = FactoryGirl.create(:spud_inquiry)
      lambda {
        delete :destroy,:id => "23532"
      }.should_not change(SpudInquiry,:count)
      response.should be_redirect
    end
  end
end
