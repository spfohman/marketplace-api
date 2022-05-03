Rails.application.routes.draw do
  namespace :api do 
  # resources :category_items
    resources :categories, only: [:index, :show]
    resources :items , only: [:index, :show, :update] 
  # get '/items', to: 'items#index' 
  # get '/items', to: 'items#show'
    resources :users, only: [:create, :destroy, :index, :show]
    post '/signup', to: 'users#create'
    get '/me', to: 'users#show'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end 
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end
