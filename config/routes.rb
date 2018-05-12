Rails.application.routes.draw do
<<<<<<< HEAD
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, only: %i(new create destroy)
  get '/auth/:provider/callback/', to: 'sessions#callback'

  root to: 'home#index'
=======
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users
  get 'landing', to: 'static_pages#landing'
  get 'dashboard', to: 'dashboard#index'
  root 'static_pages#landing'
  get '/auth/spotify/callback', to: 'users#spotify'  # getting data from spotify
>>>>>>> master
end
