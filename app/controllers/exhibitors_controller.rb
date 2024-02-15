class ExhibitorsController < ApplicationController
    def show
        @exhibitor = Exhibitor.find(params[:id])
        @event = @exhibitor.event
        @participation = Participation.participation_for(current_user, @event)
        @visible_in_participants = {}

        if @participation.present?
            @visible_in_participants[@event.id] = @participation.visible_in_participants
        else
            # S'il n'y a pas de participation, définissez la visibilité sur false
            @visible_in_participants[@event.id] = false
        end
    end
end
