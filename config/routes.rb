Rails.application.routes.draw do

  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :update] do
    member do
      get 'settings'  # crée la route /users/:id/settings
      get 'my_events'
    end
  end
  
  resources :events, only: [:index, :show] do
    resources :participations, only: [:create, :destroy]
  end
  
end
