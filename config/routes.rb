Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :inquiries
   		resources :inquiry_forms
   	end
   end
   
end

