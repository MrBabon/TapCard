class EntreprisesController < ApplicationController
    before_action :set_entreprise, only: [:edit, :update, :add_representatives]
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
      @entrepreneurs = @entreprise.entrepreneurs.includes(:user)
      @existing_representatives = existing_representatives
      @employee_options = @entreprise.employee_relationships.where.not(id: @existing_representatives).map do |employee|
        [employee.user.full_name, employee.id]
      end
      @entrepreneur_options = @entreprise.entrepreneurs.where.not(id: @existing_representatives).map do |entrepreneur|
        [entrepreneur.user.full_name, entrepreneur.id]
      end
      @representatives = @entreprise.representatives
    end
    
    def update
        if @entreprise.update(entreprise_params)
          redirect_to @entreprise, notice: "Entreprise mise à jour avec succès."
        else
          render :edit
        end
    end

    def add_representatives
      exhibitor = Exhibitor.find(representatives_params[:exhibitor_id])
      event = exhibitor.event

      unless @entreprise.exhibitors.include?(exhibitor)
        return redirect_to edit_entreprise_path(@entreprise), alert: "Exposant non associé à cette entreprise."
      end

      current_representatives = @entreprise.exhibitors.map(&:representatives).flatten

      employee_ids = representatives_params[:employee_ids].reject(&:blank?).map(&:to_i)
      entrepreneur_ids = representatives_params[:entrepreneur_ids].reject(&:blank?).map(&:to_i)
      

      employee_ids.each do |id|
        @entreprise.representatives.create!(exhibitor: exhibitor, employee_id: id) unless id.zero?
      end
    
      entrepreneur_ids.each do |id|
        @entreprise.representatives.create!(exhibitor: exhibitor, entrepreneur_id: id) unless id.zero?
      end

      redirect_to edit_entreprise_path(@entreprise), notice: "Representative added successfully"
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

    def existing_representatives
      @entreprise.representatives.pluck(:employee_id, :entrepreneur_id).flatten.compact.uniq
    end
    
    def representatives_params
      params.require(:representative).permit(:exhibitor_id, :entreprise_id, employee_ids: [], entrepreneur_ids: [])
    end
end
