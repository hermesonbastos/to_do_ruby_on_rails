Rails.application.routes.draw do
  get    "/auth", to: "auth#new", as: :auth
  post   "/auth", to: "auth#create"
  delete "/logout", to: "auth#destroy", as: :logout

  get "/dashboard", to: "boards#index", as: :dashboard

  resources :users, only: :show

  resources :boards, only: %i[index show create]
  get :dashboard, to: "boards#index"
end
