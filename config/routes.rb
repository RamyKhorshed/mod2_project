Rails.application.routes.draw do
  # just testing
  get '/login',   to: 'sessions#new'
  post "sessions", to: "sessions#create"
  delete "sessions", to: "sessions#destroy", as: "delete_sessions"
  resources :achievements
  resources :activities do
    put '/delete', to: 'activities#delete'
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
