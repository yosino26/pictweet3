Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :users, only: :show
   
  resources :tweets do
    resources :comments, only: :create
  end
end
