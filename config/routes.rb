Rails.application.routes.draw do

  get    '/login',   to: 'sessions#new'
  post "sessions", to: "sessions#create"
  delete "sessions", to: "sessions#destroy", as: "delete_sessions"
  resources :bucketlists
  resources :achievements
  resources :activities
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
