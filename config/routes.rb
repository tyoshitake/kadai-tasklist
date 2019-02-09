Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :tasks, only: [:create, :destroy]
  
  
end
