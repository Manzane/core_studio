Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'users/registrations',
    invitations: 'invitations' 
  }
  root to: 'lessons#index'
  resources :lessons, only: [:index, :show] 
  resources :bookings, only: [:new, :create]
  
  
  resources :packages, only: [:index]

  as :users do
    resources :bookings, only: [:index, :show, :destroy]
    resources :credits, only: [:index]
    resources :orders do
      resources :payments, only: :new
    end
    resources :carts do
      resources :cart_items
    end
  end
  get "/confidentialite", to: "pages#confidentiality"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
