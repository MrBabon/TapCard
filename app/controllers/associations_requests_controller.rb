class AssociationsRequestsController < ApplicationController
    before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté
    before_action :set_association_request, only: [:approve_request, :reject_request]

    def approve_request
        user = @association_request.user
        entreprise = @association_request.entreprise

        # Créez ici la logique pour ajouter l'utilisateur à l'entreprise comme employé
        Employee.create(user: user, entreprise: entreprise)

        # Supprimez la demande d'association après l'approbation
        @association_request.destroy

        # Redirigez vers le tableau de bord de l'entreprise avec un message de succès
        redirect_to dashboard_entreprise_path(entreprise), notice: "#{user.first_name} a été ajouté à l'entreprise comme employé."
    end
    def reject_request
        entreprise = @association_request.entreprise
        @association_request.destroy
    
        redirect_to dashboard_entreprise_path(entreprise), alert: "La demande d'association a été refusée."
    end

    private

    def set_association_request
        @association_request = AssociationRequest.find(params[:id])
    end
end
