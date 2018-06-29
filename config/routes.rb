Rails.application.routes.draw do
  root "pages#index"
  resources :users
  get 'password_resets/new'
  get 'password_resets/edit'
  get  '/signup',  to: 'users#new'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
