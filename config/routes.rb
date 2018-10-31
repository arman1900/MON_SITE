Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/:token/users", to: "users#index"
      post "/:token/users", to: "users#create"
      get "/:token/user/:id", to: "users#show"
      patch "/:token/user/:id", to: "users#update"
      delete "/:token/user/:id", to: "users#destroy"
      post "/:token/login", to: "sessions#create"
      post "/:token/doctor_login", to: "sessions#doctor_create"
      delete "/:token/logout", to: "sessions#destroy"
      get "/:token/current-user", to: "sessions#show"
      get "/:token/current-doctor", to: "sessions#doctor_show"
      delete "/:token/doctor_logout", to: "sessions#doctor_destroy"
      post "/:token/reset", to: "password_resets#doctor_create"
      get "/:token/doctors", to: "doctors#index"
      post "/:token/doctors", to: "doctors#create"
      get "/:token/doctor/:id", to: "doctors#show"
      get "/:token/hospitals", to: "hospitals#index"
      post "/:token/hospitals", to: "hospitals#create"
      get "/:token/hospital/:id", to: "hospitals#show"
    end
  end

end
