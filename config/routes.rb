Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "home#index" 
  resources :users
  get 'users/:id', to: 'users#show', as: 'profile'

  resources :books
end
