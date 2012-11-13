require 'spud_core'
module Spud
	module Inquiries
		 class Engine < Rails::Engine
	    engine_name :spud_inquiries

	    config.active_record.observers = [] if config.active_record.observers.nil?
      config.active_record.observers += [:inquiry_observer]


			initializer :admin do
				Spud::Core.configure do |config|
					config.admin_applications += [{:name => "Inquiries",:thumbnail => "spud/admin/contacts_thumb.png",:url => "/spud/admin/inquiries",:order => 88}]
					if Spud::Inquiries.enable_sitemap == true
						config.sitemap_urls += [:spud_inquiries_sitemap_url]
					end
				end


			end

			initializer :liquid_form do
		    Liquid::Template.register_tag('inquiry', Spud::Inquiries::InquiryForm) if defined?(Liquid::Template)
			end
		 end
	end
end
