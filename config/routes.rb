Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :inquiries
   		resources :inquiry_forms
   	end
      namespace :inquiries do
         resource :sitemap,:only => [:show]
      end
   end

   post "contact/inquire" => "contacts#inquire"
   match "contact/thankyou" => "contacts#thankyou"
   if Spud::Inquiries.enable_routes
      match "/contact" => "contacts#show"
      match "/contact/:id" => "contacts#show"
   end




end

