class RegistrationsController < Devise::RegistrationsController
    protected

    def after_update_path_for(resource)
      user_path(resource) # Redirige vers la page de profil du user après la mise à jour du compte
    end
  end