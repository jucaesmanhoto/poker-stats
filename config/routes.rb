Rails.application.routes.draw do
  get 'tournaments/new'
  get 'hands/new'
  get 'upload_hand_history/new'
  get 'upload_hand_history/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :tournaments, only: %i[new create]
  resources :hands, only: %i[new create]
  # get '/upload-tournament', to: 'upload_tournament#new'
  # post '/summary', to: 'upload_tournament#create'

  # get '/upload-hand-history', to: 'upload_hand_history#new'
  # post '/hand-history', to: 'upload_hand_history#create'
  # Defines the root path route ("/")
  # root "articles#index"
end
