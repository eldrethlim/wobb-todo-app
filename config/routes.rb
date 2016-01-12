Rails.application.routes.draw do

  root to: "static_pages#index"
  resources :tasks, only: [:index, :create, :edit, :update] do
    post :complete, to: "tasks#complete"
  end
  
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
