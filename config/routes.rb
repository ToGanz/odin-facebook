Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  root 'static_pages#home'
  get    '/home',    to: 'static_pages#home'
  
  devise_for :users, :controllers => { registrations: 'users/registrations',
                        :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :show]

  resources :friendships, only: [:index, :destroy]
  resources :friend_requests, only: [:index, :create, :update, :destroy]

  resources :posts,          only: [:create, :destroy]
  get "post/like/:post_id" => "likes#save_like", as: :like_post
  
end
