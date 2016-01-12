Rails.application.routes.draw do

  root to: "static_pages#index"
  resources :tasks, only: [:index, :create] do
    post :complete, to: "tasks#complete"
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  # API
  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :create] do
        post :complete, to: "tasks#complete"
      end

      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
