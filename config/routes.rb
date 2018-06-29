Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/:token/users", to: "users#index"
      post "/:token/users", to: "users#create"
      get "/:token/user/:id", to: "users#show"
      patch "/:token/user/:id", to: "users#update"
      delete "/:token/user/:id", to: "users#destroy"
      post "/:token/login", to: "sessions#create"
      delete "/:token/logout", to: "sessions#destroy"
      get "/:token/current-user", to: "sessions#show"
    end
  end

end
