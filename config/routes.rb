Rails.application.routes.draw do

  root "reviews#index"
  resources :cards, :user_sessions, :reviews, :users
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit]

  get "/login" => "user_sessions#new", :as => "login"
  post "/logout" => "user_sessions#destroy", :as => "logout"
  get "/signup"  => "users#new", :as => "signup"
end
