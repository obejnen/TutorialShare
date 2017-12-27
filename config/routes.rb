Rails.application.routes.draw do
  devise_for :users
  root "tutorials#index"
  # resources :tutorials
  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [ :show ]
  resources :categories, only: [:show ]
  # resources :users
  get '/admin/panel', to: 'admin/panel#index'

  resources :tutorials do
    resources :comments
    resources :tutorials
  end

  resources :users do
    resources :comments
    resources :users
  end
  
  resources :comments

  namespace :admin do
    resources :categories, except: [:show ]
  end
end
