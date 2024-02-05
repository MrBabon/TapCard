Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :update] do
    member do
      get 'profil'
      get 'settings'  # crée la route /users/:id/settings
      get 'my_events'
      get 'qr_code'
    end
  end
  
  resources :events, only: [:index, :show] do
    resources :participations, only: [:create, :destroy]
  end
  
end
