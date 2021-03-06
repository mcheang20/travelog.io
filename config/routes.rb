Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:create, :show, :edit, :update]
  resources :categories, only: [:index, :new, :create, :show]
  resources :charges, only: [:new, :create, :destroy]
  resources :logs do
    resources :comments, only: [:create, :destroy]
    resources :pics, only: [:show, :create, :destroy]
    resources :vids, only: [:show, :create, :destroy]
    resources :votes, only: [:create, :destroy]
    resources :vids, only: [:show, :create, :destroy]
  end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :conversations do
    resources :messages, only: [:index, :create, :new]
  end

  get "/all_logs" => 'logs#all_logs', as: :all_logs
  get "/most_popular" => 'logs#most_popular', as: :most_popular
  get "/likes" => 'logs#user_likes', as: :likes
  get "/followed_users" => 'logs#followed_users', as: :followed_users

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  root 'welcome#home'
end
