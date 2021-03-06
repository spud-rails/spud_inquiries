module Spud
  module Inquiries
    include ActiveSupport::Configurable

    config_accessor :default_contact_form,:enable_routes,:mail_delivery_format,:base_layout,:from_address,:enable_sitemap,:enable_action_caching, :automount, :reply_to, :send_receipt

    self.enable_routes = true
    self.automount = true
    self.default_contact_form = "contact"
    self.base_layout = "application"
    self.mail_delivery_format = :html
    self.from_address = "no-reply@example.org"
    self.reply_to = "no-reply@example.org"
    self.enable_sitemap = true
    self.enable_action_caching = false
    self.send_receipt = false
  end
end