Rails.application.routes.draw do
  root 'posts#index'
  resources :users
  resources :user_sessions
  resources :posts
  resources :comments

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
