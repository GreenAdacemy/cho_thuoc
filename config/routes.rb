# == Route Map
#

Rails.application.routes.draw do
  # get '/products', controller: :products, action: :index;
  resources :products, only: [:index, :show]
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  root to: 'landing#index'
  get '/inventory', controller: :inventory, action: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
