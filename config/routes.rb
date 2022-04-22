Rails.application.routes.draw do
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :photos, only: [:index, :show, :new, :create]

  get '/authorize_tweet' => 'photos#authorize_tweet'
  get '/oauth/callback' => 'photos#callback'
  post 'send_tweet' => 'photos#send_tweet'
end
