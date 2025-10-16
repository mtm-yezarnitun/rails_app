Rails.application.routes.draw do
  root "home#index"
  
  resources :users
  resources :posts
end
