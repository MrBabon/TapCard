class ParticipationsController < ApplicationController
    before_action :set_event, only: [:create]
    before_action :set_participation, only: [:destroy]

    def create
        @participation = Participation.new(participation_params)
        @participation.user = current_user
        unless @event.valid_registration_code?(@participation.registration_code)
            flash[:alert] = "Code de participation incorrect."
            redirect_to event_path(@event) and return
        end
      
        if @participation.save
            redirect_to event_path(@event), notice: "Inscription réussie."
        else
            render 'new'
        end
        # authorize @participation
    end

    def destroy
        @event = Event.find(params[:event_id])
        @participation.destroy
        redirect_to event_path(@event)
        flash[:notice] = "Votre inscription a été supprimée avec succès."
        # authorize @participation
    end

    private

    def participation_params
        params.require(:participation).permit(:event_id, :registration_code)
    end
    
    def event_params
        params.require(:event).permit(:event_id)
    end

    def set_participation
        @participation = Participation.find(params[:id])
    end

    def set_event
        if params[:participation] && params[:participation][:event_id]
            @event = Event.find(params[:participation][:event_id])
          else
            # Gérer le cas où les paramètres nécessaires ne sont pas définis
            flash[:alert] = "Paramètres invalides pour l'événement."
            redirect_to events_path # ou une autre redirection
          end
    end
      
end
