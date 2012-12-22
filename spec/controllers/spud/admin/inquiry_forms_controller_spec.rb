require 'spec_helper'

describe Spud::Admin::InquiryFormsController do
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
      2.times {|x|  s = FactoryGirl.create(:spud_inquiry_form)}
      get :index, :use_route => :spud_core
      assigns(:inquiry_forms).count.should be > 1
    end
  end

  describe :new do
    it "should respond with a new form" do
      get :new, :use_route => :spud_core
      assigns(:inquiry_form).should_not be_blank
      response.should be_success
    end
  end

  describe :create do
    it "should create a new form with a valid form submission" do
      lambda {
        post :create, :use_route => :spud_core, :spud_inquiry_form => FactoryGirl.attributes_for(:spud_inquiry_form).reject{|k,v| k == 'site_id' || k == 'id'}
      }.should change(SpudInquiryForm,:count).by(1)
      response.should be_redirect
    end

    it "should not create a form with an invalid form entry" do
      lambda {
        post :create, :use_route => :spud_core, :spud_inquiry_form => FactoryGirl.attributes_for(:spud_inquiry_form,:name => nil).reject{|k,v| k == 'site_id' || k == 'id'}
      }.should_not change(SpudInquiryForm,:count)
    end
  end

  describe :edit do
    it "should respond with form by id" do
      form1 = FactoryGirl.create(:spud_inquiry_form)
      form2 = FactoryGirl.create(:spud_inquiry_form)
      get :edit, :use_route => :spud_core,:id => form2.id
      assigns(:inquiry_form).should == form2
    end

    it "should redirect to index if form not found" do
      get :edit, :use_route => :spud_core,:id => 1234
      response.should redirect_to spud_core.admin_inquiry_forms_url
    end
  end

  describe :update do
    it "should update the name when the name attribute is changed" do
      form = FactoryGirl.create(:spud_inquiry_form)
      new_name = 'MyForm'
      lambda {
        put :update, :use_route => :spud_core,:id => form.id, :spud_inquiry_form => form.attributes.merge!(:name => new_name).reject{|k,v| k == 'site_id' || k == 'id'}
        form.reload
      }.should change(form,:name).to(new_name)

    end

    it "should redirect to the admin forms after a successful update" do
      form = FactoryGirl.create(:spud_inquiry_form)
      put :update, :use_route => :spud_core,:id => form.id,:spud_menu => form.attributes.merge!(:name => "MyMenu").reject{|k,v| k == 'site_id' || k == 'id'}
      response.should redirect_to(spud_core.admin_inquiry_forms_url)
    end
  end

  describe :destroy do
    it "should destroy the form" do
      form = FactoryGirl.create(:spud_inquiry_form)
      lambda {
        delete :destroy, :use_route => :spud_core, :id => form.id
      }.should change(SpudInquiryForm,:count).by(-1)
      response.should be_redirect
    end

    it "should not destroy the form with a wrong id" do
      menu = FactoryGirl.create(:spud_inquiry_form)
      lambda {
        delete :destroy, :use_route => :spud_core,:id => "23532"
      }.should_not change(SpudInquiryForm,:count)
      response.should be_redirect
    end
  end
end
