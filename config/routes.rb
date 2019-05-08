Rails.application.routes.draw do
  root 'posts#index'
  resources :users
  resources :user_sessions
  resources :posts do
    resources :comments
  end
  namespace :api, { format: 'json' } do
    resources :posts do
      resources :comments
    end
  end

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
