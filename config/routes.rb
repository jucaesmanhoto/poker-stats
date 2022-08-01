Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/upload', to: 'upload#new'
  post '/upload', to: 'upload#create_tournament_summary'
  # Defines the root path route ("/")
  # root "articles#index"
end
