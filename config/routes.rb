Rails.application.routes.draw do

  root "reviews#index"
  resources :cards, :reviews
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :registrations, only: [:new, :create]
  resources :profiles, only: [:edit, :update, :show]

  get "/login" => "user_sessions#new", :as => "login"
  post "/logout" => "user_sessions#destroy", :as => "logout"
  get "/signup" => "registrations#new", :as => "signup"
  get "/users" => "profiles#index", :as => "users"

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
end
