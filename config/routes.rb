Rails.application.routes.draw do

  root "dashboard#index"

  match "/404" => "errors#error404", via: [:get, :post, :patch, :delete]

  namespace :dashboard do
    root "reviews#index"
    resources :reviews, :cards
    resources :decks do
      put "set_current", on: :member
    end
    resources :user_sessions, only: [:destroy]
    resources :profiles, only: [:edit, :update, :show, :destroy]
    delete "/logout" => "user_sessions#destroy", :as => "logout"
    # profiles
    get "/users" => "profiles#index", :as => "users"
  end

  namespace :home do
    root "user_sessions#new"
    resources :user_sessions, only: [:new, :create]
    resources :registrations, only: [:new, :create]
    # registrations
    get "/signup" => "registrations#new", :as => "signup"

    # sessions
    get "/login" => "user_sessions#new", :as => "login"

    # oauth
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  end
end
