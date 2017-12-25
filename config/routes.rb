Rails.application.routes.draw do
  devise_for :users
  root "tutorials#index"
  resources :tutorials
  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [ :show ]
  resources :categories
end
