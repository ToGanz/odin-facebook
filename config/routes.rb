Rails.application.routes.draw do

  root 'static_pages#home'
  get    '/home',    to: 'static_pages#home'
  
  devise_for :users, :controllers => { registrations: 'users/registrations',
                        :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :show]

  resources :friendships, only: [:index, :destroy]
  resources :friend_requests, only: [:index, :create, :update, :destroy]

  
  resources :posts, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  
end
