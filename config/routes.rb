Rails.application.routes.draw do
  root "pages#index"
  resources :users
  get  '/signup',  to: 'users#new'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
