Rails.application.routes.draw do
  devise_for :users
  root to: 'lessons#index'
  resources :lessons, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show, :destroy]
  resources :credits, only: [:index]
  resources :packages, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
