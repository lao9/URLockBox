Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: "links#index"

  resources :links, only: [:index, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :update]
    end
  end
end
