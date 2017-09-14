Rails.application.routes.draw do

  get 'sessions/new'

  root "static_pages#home"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/contact', to: "static_pages#contact"
  get '/help'   , to: "static_pages#help"
  get '/about'  , to: "static_pages#about"
  
  get '/signup', to: "users#new"
  post '/signup' => "users#create"

  get '/login'    , to: "sessions#new"
  post '/login'   , to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :users
  resources :account_activations, only: [:edit]
end
