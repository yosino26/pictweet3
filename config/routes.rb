Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :users, only: :show
   
  resources :tweets do
    resources :comments, only: :create

    # ★ここを追加（いいね機能）
    resource :likes, only: [:create, :destroy]
    
    collection do
      get 'search'
    end
  end
end
