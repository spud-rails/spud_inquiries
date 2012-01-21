require 'spud_admin'
module Spud
	module Inquiries
		 class Engine < Rails::Engine
		    engine_name :spud_inquiries
			initializer :admin do
				Spud::Core.configure do |config|
					config.admin_applications += [{:name => "Inquiries",:thumbnail => "spud/admin/contacts_thumb.png",:url => "/spud/admin/inquiries",:order => 88}]
				end
			end
		 end
	end
end
