module Spud
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :default_contact_form,:mail_delivery_format,:base_layout,:from_address,:enable_sitemap

    self.default_contact_form = "contact"
    self.base_layout = "application"
    self.mail_delivery_format = :html
    self.from_address = "no-reply@example.org"
    self.enable_sitemap = true
  end
end