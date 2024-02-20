Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :update, :index] do
    member do
      get 'profil'
      get 'settings'  # crée la route /users/:id/settings
      get 'my_events'
      post :follow
      post :unfollow
      get 'qr_code'
    end
  end

  resources :associations_requests do
    member do
      post 'approve_request'
      delete 'reject_request'
    end
  end

  
  resources :events, only: [:index, :show] do
    member do
      get 'visitor'
      get 'exposant'
    end
    resources :participations, only: [:create, :destroy]
  end
  resources :participations, only: [:update]
  resources :exhibitors, only: [:show]
  resources :entreprises, only: [:edit, :update] do
    resources :employees, only: [:destroy]
    member do
      post 'add_representatives'
    end
  end
  
end
