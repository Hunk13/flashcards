Rails.application.routes.draw do

  root "reviews#index"
  resources :cards, :reviews, :users
  resources :user_sessions, only: [:new, :create, :destroy]

  get "/login" => "user_sessions#new", :as => "login"
  post "/logout" => "user_sessions#destroy", :as => "logout"
  get "/signup"  => "users#new", :as => "signup"

  get "oauth/callback" => "oauths#callback"
  post "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth
end
