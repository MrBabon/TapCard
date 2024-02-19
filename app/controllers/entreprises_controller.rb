class EntreprisesController < ApplicationController
    before_action :set_entreprise, only: [:edit, :update]
    before_action :verify_ownership, only: [:edit, :update]
  
    def create
      @entreprise = Entreprise.new(entreprise_params)
      
      if @entreprise.save
        # Reste du code de création de l'entreprise...
      else
        render :new
      end
    end

    def edit
      @entreprise = Entreprise.find(params[:id])
      @association_requests = @entreprise.association_requests.where(status: 'pending')
      @employees = @entreprise.employees
    end
    
    def update
        if @entreprise.update(entreprise_params)
          redirect_to @entreprise, notice: "Entreprise mise à jour avec succès."
        else
          render :edit
        end
    end
  
    private
  
    def set_entreprise
      @entreprise = Entreprise.find(params[:id])
    end

    def verify_ownership
      unless current_user.entreprises_as_owner.include?(@entreprise)
        redirect_to root_path, alert: "Vous n'avez pas les droits pour modifier cette entreprise."
      end
    end
  
    def entreprise_params
      params.require(:entreprise).permit(:name, :logo, :email, :website, :linkedin, :instagram, :facebook, :twitter, :description)
    end
end
