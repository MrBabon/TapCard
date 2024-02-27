class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_signed_in
  helper_method :desktop_device?


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :avatar, :job, :biography, :industry, :website, :linkedin, :instagram, :facebook, :twitter, :entreprise_code])
  end

  protected

  def after_sign_in_path_for(resource)
    if desktop_device?
      if resource.entrepreneurs.present?
        entrepreneur = resource.entrepreneurs.first
        if entrepreneur.entreprise.present?
          dashboard_entreprise_path(entrepreneur.entreprise)
        end
      else
        new_entreprise_path
      end
    else
      profil_user_path(resource) # Redirige vers la page de profil du user après la connexion
    end
  end

  def after_sign_up_path_for(resource)
    if desktop_device?
      new_entreprise_path
    else
      profil_user_path(resource) # Redirige vers la page de profil du user après l'inscription
    end
  end

  def after_inactive_sign_up_path_for(resource)
    if desktop_device?
      if resource.entrepreneurs.present?
        dashboard_entreprise_path(resource.entrepreneurs.entreprise)
      else
        new_entreprise_path
      end
    else
      profil_user_path(resource)
    end
  end


  def check_user_signed_in
    if user_signed_in? && request.original_fullpath == root_path
      redirect_to profil_user_path(current_user)
    end
  end

  def desktop_device?
    browser = Browser.new(request.user_agent)
    !browser.device.mobile? && !browser.device.tablet?
  end

end
