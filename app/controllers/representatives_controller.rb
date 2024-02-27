class RepresentativesController < ApplicationController
    before_action :set_representative, only: [:destroy]

    def destroy
        entreprise = @representative.entreprise
        @representative.destroy

        redirect_to dashboard_entreprise_path(entreprise), alert: "Representative removed"
    end

    private

    def set_representative
        @representative = Representative.find(params[:id])
    end
end
