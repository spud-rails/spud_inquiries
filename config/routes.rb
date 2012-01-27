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
   match "/contact" => "contacts#show"
   post "contact/inquire" => "contacts#inquire"
   match "contact/thankyou" => "contacts#thankyou"
   match "/contact/:id" => "contacts#show"

   
end

