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
      get "/:token/company/:id", to: "companies#show"
      get "/:token/company/:id/posts", to: "companies#all_posts"
      post "/:token/companies", to: "companies#create"
      patch "/:token/company/:id", to: "companies#update"
      delete "/:token/company/:id", to: "companies#destroy"
      patch "/:token/company/:id/user", to: "companies#add_user"
      delete "/:token/company/:id/user", to: "companies#remove_user"
      post "/:token/categories", to: "categories#create"
      get "/:token/categories/:id", to: "categories#show"
      patch "/:token/categories/:id", to: "categories#update"
      delete "/:token/categories/:id", to: "categories#destroy"
      post "/:token/icons", to: "icons#create"
      get "/:token/icon/:id", to: "icons#show"
      patch "/:token/icon/:id", to: "icons#update"
      delete "/:token/icon/:id", to: "icons#delete"
      post "/:token/posts", to: "posts#create"
      get "/:token/post/:id", to: "post#show"
      patch "/:token/post/:id", to: "post#update"
      delete "/:token/post/:id", to: "post#destroy"
    end
  end

end
