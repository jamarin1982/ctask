Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :authentication, path: "", as: "" do
    resources :users, only: [ :new, :create ], path: "/register", path_names: { new: "/" }
    resources :sessions, only: [ :new, :create, :destroy ], path: "/login", path_names: { new: "/" }
  end

  # resources :home, only: :index, path: "/", as: "home"
  # get "home", to: "home#index", as: "home", path: ""

  resources :categories, except: :show
  resources :tasks do
    member do
      patch :verify
      patch :develop
      patch :reject
      patch :deliver
      patch :unverify
      patch :undevelop
      patch :unreject
    end
  end
  root to: "home#index", as: "home"
end
