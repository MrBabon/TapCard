class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :avatar, :job, :biography, :industry, :website, :linkedin, :instagram, :facebook, :twitter])
  end

  protected

  def after_sign_in_path_for(resource)
    user_path(resource) # Redirige vers la page de profil du user après la connexion
  end

  def after_sign_up_path_for(resource)
    user_path(resource) # Redirige vers la page de profil du user après l'inscription
  end

end
