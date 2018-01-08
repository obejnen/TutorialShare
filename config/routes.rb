Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root "tutorials#recent"

  post '/rate' => 'rater#create', :as => 'rate'
  
  get '/settings', to: 'settings#index'
  get '/admin/users/:id/chrole', to: 'admin/users#change_role'
  get '/admin/users/:id/ban', to: 'admin/users#ban'
  get "/users/:user_id/tutorials", to: "users#tutorials"
  get "/users/:user_id/comments", to: "users#comments"
  put "/set_locale", to: "users#set_locale"
  put "/set_theme", to: "users#set_theme"

  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [ :show ]
  resources :categories, only: [:show ]
  get :search, controller: :tutorials
  
  resources :tutorials do
    resources :comments do
      member do
        put "like", to: "comments#like"
      end
    end
    resources :tutorials
  end
  
  resources :users do
    resources :comments
    resources :tutorials
  end
  
  resources :comments
  
  namespace :admin do
    resources :categories, except: [:show ]
    resources :tutorials, only: [:index]
    resources :users, only: [:index]
    resources :comments, only: [:index]
  end
end

