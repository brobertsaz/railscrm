RebelFoundation::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    match "logout" => "devise/sessions#destroy", :as => "logout"  
    match "login" => "devise/sessions#new", :as => "login"  
    match "signup" => "devise/registrations#new", :as => "signup"  
  end

  resources :organizations
  resources :leads
  resources :tasks
  resources :contacts
  resources :accounts
  resources :opportunities
   
  root to: 'pages#index'
end
