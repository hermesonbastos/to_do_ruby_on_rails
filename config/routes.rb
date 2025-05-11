Rails.application.routes.draw do
  get    "/auth",   to: "auth#new",     as: :auth
  post   "/auth",   to: "auth#create"
  delete "/logout", to: "auth#destroy", as: :logout

  resources :users, only: :show

  resources :boards, only: %i[index show create] do
    resources :columns, only: %i[create update destroy] do
      patch :reorder, on: :collection
    end
  end
end
