Rails.application.routes.draw do
  
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get "likes"
    end
  end
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :posts, only: [:new, :show, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  
  get "ranking", to: "rankings#like"
  
  
  
end
