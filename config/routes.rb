RebelFoundation::Application.routes.draw do
  
  resources :organizations
  
  resources :users do
    put 'update_password'
  end
    
  resources :leads
  resources :tasks
  resources :contacts
  resources :accounts
    
    
  match '/dashboard'        => 'users#dashboard',       as: :dashboard
  match '/forgot_password'  => 'users#forgot_password', as: :forgot_password
  match '/reset_password'   => 'users#reset_password',  as: :reset_password
  
  resource  :user_session
  match '/login'            => 'user_session#new',      as: :login
  match '/logout'           => 'user_session#destroy',  as: :logout

  # OAuth how you humor me so ...
  match '/auth/:provider/callback'  => 'user_session#create'
  match '/auth/failure'             => 'user_session#failure'

  root to: 'pages#index'
end
