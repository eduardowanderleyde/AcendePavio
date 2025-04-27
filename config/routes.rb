Rails.application.routes.draw do
  get 'about/index'
  get 'carts/show'
  get 'carts/add'
  get 'carts/remove'
  get 'carts/update'
  devise_for :users
  root 'home#index'
  
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  
  # Namespace para área administrativa
  namespace :admin do
    resources :products
    resources :categories
  end

  resources :carts, only: [:show] do
    member do
      post :add
      post :remove
      patch :update
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get '/up', to: 'health#up'

  # Defines the root path route ("/")
  # root "posts#index"

  get 'sobre', to: 'about#index', as: :about
end
