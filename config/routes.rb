Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users
  get 'users/:id', to: 'users#show', as: 'profile'

  resources :books do
    collection do
      get 'search'
    end
  end

  resources :borrowed_books do
    collection do
      get 'user_borrowed_books'
    end
  end
end
