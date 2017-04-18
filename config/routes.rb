Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:create, :show, :edit, :update]
  resources :logs do
    resources :comments, only: [:create, :destroy]
    resources :pics, only: [:show, :create, :destroy]
    resources :votes, only: [:create, :destroy]
  end

  resources :categories, only: [:index, :new, :create,:show]

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get "/all_logs" => 'logs#all_logs', as: :all_logs
  root 'welcome#home'
end
