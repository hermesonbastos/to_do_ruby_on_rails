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

  resources :columns, only: [] do
    resources :tasks, only: %i[create show update destroy] do
      collection do
        patch :reorder
      end
      member do
        patch :move
      end
    end
  end
end
