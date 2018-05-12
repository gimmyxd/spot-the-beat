Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users
  resources :sessions, only: %i(new create)

  post '/sign_out' => 'sessions#destroy'

  get 'landing', to: 'static_pages#landing'
  get 'dashboard', to: 'dashboard#index'
  root 'static_pages#landing'
  get '/auth/:provider/callback/', to: 'sessions#callback'
end
