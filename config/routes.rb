Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA endpoints
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise routes for user authentication
  devise_for :users

  # Root path
  root "cards#index"

  # Resource routes
  resources :cards, :decks
  resources :users, except: :show
  resources :comments, only: [ :create, :destroy ]
end
