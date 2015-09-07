Rails.application.routes.draw do

  root "reviews#index"
  resources :reviews, :cards
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :registrations, only: [:new, :create]
  resources :profiles, only: [:edit, :update, :show, :destroy]

  # sessions
  get "/login" => "user_sessions#new", :as => "login"
  delete "/logout" => "user_sessions#destroy", :as => "logout"

  # registrations
  get "/signup" => "registrations#new", :as => "signup"

  # profiles
  get "/users" => "profiles#index", :as => "users"

  # oauth
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
end
