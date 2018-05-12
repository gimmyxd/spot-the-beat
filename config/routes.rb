Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users
  get 'landing', to: 'static_pages#landing'
  get 'dashboard', to: 'dashboard#index'
  root 'static_pages#landing'
  get '/auth/spotify/callback', to: 'users#spotify'  # getting data from spotify
end
