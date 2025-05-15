Rails.application.routes.draw do
  root to: "auth#new"

  get    "/auth",   to: "auth#new",     as: :auth
  post   "/auth",   to: "auth#create"
  delete "/logout", to: "auth#destroy", as: :logout
  get "/auth/:provider/callback", to: "omniauth#google_oauth2"
  get "/auth/failure", to: "omniauth#failure"

  resources :users, only: :show

  resources :boards, only: %i[index show create destroy] do
    resources :columns, only: %i[create update destroy] do
      patch :reorder, on: :collection
    end

    resources :labels, only: [ :index, :create ]
  end

  resources :tasks do
    resources :labels, only: [] do
      member do
        post :add_to_task
        delete :remove_from_task
      end
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
