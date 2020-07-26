Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'orders/create'
  devise_for :users
  root to: 'lessons#index'
  resources :lessons, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
  end
  
  resources :packages, only: [:index]

  as :users do
    resources :bookings, only: [:index, :show, :destroy]
    resources :credits, only: [:index]
    resources :orders
    resources :carts do
      resources :cart_items
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
