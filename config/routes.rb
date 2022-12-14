Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "/"

  resources :tournaments, only: %i[new create]
  resources :hands, only: %i[new create index]
  resources :tournament_stats, only: %i[index show]
  # get '/upload-tournament', to: 'upload_tournament#new'
  # post '/summary', to: 'upload_tournament#create'

end
