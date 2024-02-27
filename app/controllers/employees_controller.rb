class EmployeesController < ApplicationController
    before_action :set_entreprise
    before_action :set_employee, only: [:destroy]

    def destroy
        @employee.destroy
        redirect_to dashboard_entreprise_path(@entreprise), notice: "L'employé a été supprimé avec succès."
    end

    private

    def set_entreprise
        @entreprise = Entreprise.find(params[:entreprise_id])
    end

    def set_employee
        @employee = @entreprise.employee_relationships.find(params[:id])
        unless @employee    
            redirect_to dashboard_entreprise_path(params[:entreprise_id]), alert: "Relation employé non trouvée."
        end
    end
end
