Rails.application.routes.draw do
  devise_for :users
  root "tutorials#index"
  get 'tutorials/new'

  get 'tutorial/new'

  resources :tutorials
end
