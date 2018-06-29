Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/:token/users", to: "users#index"
      post "/:token/users", to: "users#create"
      get "/:token/user/:id", to: "users#show"
      patch "/:token/user/:id", to: "users#update"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
