Rails.application.routes.draw do
  root "auth#new"

  get  "/auth", to: "auth#new", as: :auth
  post "/auth", to: "auth#create"

  get  "/signup", to: "users#new", as: :signup
  post "/signup", to: "users#create"

  get    "/login",  to: "sessions#new", as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
get '/auth/:provider/callback', to: 'sessions#google_auth'
get '/auth/:provider', to: 'sessions#passthru', as: :auth_request # opcional para Rails 7+
  resources :users, only: [ :new, :create, :show ]
end
