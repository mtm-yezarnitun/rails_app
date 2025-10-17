Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root "home#index"
  
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :posts
  resources :categories
end
