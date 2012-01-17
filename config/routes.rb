Rails.application.routes.draw do
   namespace :spud do
   	namespace :admin do
   		resources :inquiries
   	end
   end
   
end

