class EventsController < ApplicationController

    def index
        @events = Event.all
        @participation = Participation.participation_for(current_user, @event)
    end

    def show
        @event = Event.find(params[:id])
    end
end
