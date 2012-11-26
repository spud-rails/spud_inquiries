Spud::Core::Engine.routes.draw do
  scope :module => "spud" do
    namespace :admin do
       resources :inquiries
       resources :inquiry_forms
    end
    namespace :inquiries do
       resource :sitemap,:only => [:show]
    end
  end
end

Spud::Inquiries::Engine.routes.draw do
  post "inquire" => "contacts#inquire"
  match "thankyou" => "contacts#thankyou"
  if Spud::Inquiries.enable_routes
    match "/" => "contacts#show", :as => :contact
    match "/:id" => "contacts#show", :as => :contact
  end
end

Rails.application.routes.draw do
  if Spud::Inquiries.config.automount
    mount Spud::Inquiries::Engine, :at => "/contact"
  end
end

