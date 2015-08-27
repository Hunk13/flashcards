Rails.application.routes.draw do

  root "reviews#index"
  resources :cards, :reviews, :users
  resources :user_sessions, only: [:new, :create, :destroy]

  get "/login" => "user_sessions#new", :as => "login"
  post "/logout" => "user_sessions#destroy", :as => "logout"
  get "/signup"  => "users#new", :as => "signup"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end 
