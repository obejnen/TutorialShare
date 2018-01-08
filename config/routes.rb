Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'
  root "tutorials#recent"
  
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # resources :tutorials
  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [ :show ]
  resources :categories, only: [:show ]
  get :search, controller: :tutorials
  get :autocomplete, controller: :tutorials
  get '/settings', to: 'settings#index'
  # resources :users
  get '/admin/panel', to: 'admin/panel#index'
  get '/admin/:user_id/ban', to: 'users#ban'
  get '/admin/users/:id/chrole', to: 'admin/users#change_role'
  get '/admin/users/:id/ban', to: 'admin/users#ban'
  get "/users/:user_id/tutorials", to: "users#tutorials"
  get "/users/:user_id/comments", to: "users#comments"
  put "/set_locale", to: "users#set_locale"
  put "/set_theme", to: "users#set_theme"
  # get '/admin/users', to: 'admin/users#index'
  # get '/admin/panel/tutorials', to: 'panel#tutorials'

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
    # resources :users, except: [:index]
  end
  
  resources :comments

  namespace :admin do
    resources :categories, except: [:show ]
    resources :tutorials, only: [:index]
    resources :users, only: [:index]
    resources :comments, only: [:index]
  end
end
