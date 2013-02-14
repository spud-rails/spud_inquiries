require 'spud_core'
require 'liquid'
module Spud
	module Inquiries
		 class Engine < Rails::Engine
	    engine_name :spud_inquiries

			initializer :admin do
				Spud::Core.configure do |config|
					config.admin_applications += [{:name => "Inquiries",:thumbnail => "spud/admin/contacts_thumb.png",:url => "/spud/admin/inquiries",:order => 88}]
					if Spud::Inquiries.enable_sitemap == true
						config.sitemap_urls += [:spud_inquiries_sitemap_url]
					end
				end
			end

			initializer :liquid_form do
				Spud::Inquiries::FormActionView.class_eval do
					include Spud::Inquiries::Engine.routes.url_helpers
	        include Spud::Inquiries::Engine.routes.mounted_helpers
				end
		    Liquid::Template.register_tag('inquiry', Spud::Inquiries::InquiryForm) if defined?(Liquid::Template)
			end
		 end
	end
end
