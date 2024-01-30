Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :update] do
    member do
      get 'settings'  # crée la route /users/:id/settings
    end
  end
  root to: "pages#home"

end
