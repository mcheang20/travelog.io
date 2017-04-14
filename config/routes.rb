Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:create, :show, :edit, :update]
  resources :logs

  get "/all_logs" => 'logs#all_logs', as: :all_logs
  root 'welcome#home'
end
