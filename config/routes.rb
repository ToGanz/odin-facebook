Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/home',    to: 'static_pages#home'
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :friendships, only: [:index, :destroy]
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  
end
