Rails.application.routes.draw do
  get 'contact_groups/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :update, :index] do
    resources :users_contact_groups, only: [:update]
    member do
      get 'profil'
      get 'settings'  # crée la route /users/:id/settings
      get 'my_events'
      post :follow
      post :unfollow
      get 'qr_code'
      get 'repertoire'
      post 'add_to_directory'
      get 'repertoire_user_profile'
    end
  end
  resources :contact_groups, only: [:show]
  


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
  resources :representatives, only: [:destroy]
  resources :entreprises, only: [:edit, :update, :show, :new, :create] do
    resources :employees, only: [:destroy]
    resources :contact_entreprises, only: :create
    member do
      post 'add_representatives'
      get 'dashboard'
    end
  end
  
end
