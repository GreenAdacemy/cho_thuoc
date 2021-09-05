# == Route Map
#
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  # get '/products', controller: :products, action: :index;
  resources :products, only: [:index, :show]
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  root to: 'landing#index'
  get '/inventory', controller: :inventory, action: :index
  get '/orders', controller: :orders, action: :index
  get '/checkout', controller: :checkout, action: :index
  
  resources :users, only: [] do
    resource :profile, controller: :profile
    resources :orders
 end

 mount ActionCable.server => '/cable'
 resources :users, only: [] do
   resource :profile, controller: :profile
   resources :orders
   get 'shipping_info', controller: :orders
   post 'add_shipping_info', controller: :orders
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
