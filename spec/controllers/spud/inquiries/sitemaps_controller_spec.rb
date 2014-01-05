require 'spec_helper'

describe Spud::Inquiries::SitemapsController do
  describe :show do
    before(:each) do
      Spud::Core.configure do |config|
        config.site_name = "Test Site"
        config.multisite_mode_enabled = false
        config.multisite_config = []
      end
    end

    it "should return the sitemap urls" do
      get :show, :format => :xml
      assigns(:forms).should == SpudInquiryForm.all
    end

    it "should only respond to an XML format" do
      expect {
        get :show
      }.to raise_exception(ActionController::UnknownFormat)
    end
  end
end
