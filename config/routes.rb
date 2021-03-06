Rails.application.routes.draw do
  root 'posts#index'
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments
  end
  namespace :api, { format: 'json' } do
    resources :posts, only: [:index, :show]
  end

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
