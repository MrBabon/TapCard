class RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    super do |user|
      if user.persisted? && params[:user][:entreprise_code].present?
        if user.associate_with_entreprise(params[:user][:entreprise_code])
          flash[:notice] = "Le code de parrainage est valide. Votre demande d'association a été envoyée."
        else
          flash[:alert] = user.errors.full_messages.to_sentence
        end
      end
    end
  end
  protected
  
  def process_association_request(user, code)
    if user.need_to_process_enterprise_code?(code)
      if user.associate_with_entreprise(code)
        flash[:notice] = "Le code de parrainage est valide. Votre demande d'association a été envoyée."
      else
        flash[:alert] = "Le code de parrainage est invalide ou une demande existe déjà."
      end
    end
  end

  def after_update_path_for(resource)
    user_path(resource) # Redirige vers la page de profil du user après la mise à jour du compte
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :avatar, :job, :biography, :industry, :website, :linkedin, :instagram, :facebook, :twitter, :entreprise_code])
  end

end