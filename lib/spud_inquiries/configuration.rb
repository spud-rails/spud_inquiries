module Spud
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :default_contact_form,:mail_delivery_format,:base_layout

    self.default_contact_form = "contact"
    self.base_layout = "application"
    self.mail_delivery_format = :html
    
  end
end