Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get    '/home',    to: 'static_pages#home'
end
