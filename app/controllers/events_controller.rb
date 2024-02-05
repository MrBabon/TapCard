class EventsController < ApplicationController

    def index
        @events = Event.all
        @participations = {}
        @events.each do |event|
          @participations[event.id] = Participation.participation_for(current_user, event)
        end
    end

    def show
        @event = Event.find(params[:id])
        @participation = Participation.participation_for(current_user, @event)
    end

    private

    def user_params
        params.require(:user).permit(:title, :logo, :address, :description, :link, :start_time, :end_time, :registration_code)
      end

    def map_view(event)
        {
        lat: event.latitude,
        lng: event.longitude,
        city: event.city,
        country: event.country,
        info_window_html: render_to_string(partial: "info_window", locals: {event: event})
        }
    end
end