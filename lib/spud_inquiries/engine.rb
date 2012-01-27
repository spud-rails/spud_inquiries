require 'spud_admin'
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
		 end
	end
end
