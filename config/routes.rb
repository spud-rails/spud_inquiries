Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :inquiries
   		resources :inquiry_forms
   	end
   end
   match "/contact" => "contacts#show"
   post "contact/inquire" => "contacts#inquire"
   match "/contact/:id" => "contacts#show"

   
end

