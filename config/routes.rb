Rails.application.routes.draw do
  get 'landing', to: 'static_pages#landing'
  get 'dashboard', to: 'dashboard#index'
  root 'static_pages#landing'
end
