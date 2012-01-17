module SpudInquiries
   require 'spud_inquiries/engine' if defined?(Rails)
   SpudAdmin::Engine.add_admin_application({:name => "Inquiries",:thumbnail => "spud/admin/contacts_thumb.png",:url => "/spud/admin/inquiries",:order => 99})
end
