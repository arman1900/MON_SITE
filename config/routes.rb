Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/:token/users", to: "users#index"
      post "/:token/users", to: "users#create"
      get "/:token/user/:id", to: "users#show"
      patch "/:token/user/:id", to: "users#update"
      delete "/:token/user/:id", to: "users#destroy"
      get "/:token/user-locked-times/:id", to: "users#show_locked_times"
      post "/:token/login", to: "sessions#create"
      post "/:token/doctor-login", to: "sessions#doctor_create"
      delete "/:token/logout", to: "sessions#destroy"
      get "/:token/current-user", to: "sessions#show"
      get "/:token/current-doctor", to: "sessions#doctor_show"
      delete "/:token/doctor-logout", to: "sessions#doctor_destroy"
      post "/:token/reset", to: "password_resets#doctor_create"
      get "/:token/doctors", to: "doctors#index"
      post "/:token/doctors", to: "doctors#create"
      get "/:token/doctor/:id", to: "doctors#show"
      get "/:token/hospitals", to: "hospitals#index"
      post "/:token/hospitals", to: "hospitals#create"
      get "/:token/hospital/:id", to: "hospitals#show"
      get "/:token/services", to: "services#index"
      get "/:token/service/:id", to: "services#show"
      post "/:token/lock-time", to: "users#create_locked_time_all"
      post "/:token/doctor-lock-time", to: "users#create_locked_time_doctor"
      get "/:token/doctor-lock-times", to: "doctors#show_locked_times"
      patch "/:token/accept-request/:id", to: "doctors#accept_time" 
      delete "/:token/reject-request/:id", to: "doctors#reject_time"
    end
  end
end
