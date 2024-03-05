class RepertoiresController < ApplicationController
    before_action :authenticate_user!
    before_action :set_repertoire, only: [:show]
    def show
        @repertoire = current_user.repertoire
        @groups = current_user.contact_groups.includes(:users)
        if params[:search].present?
          @everyone_group = @groups.find_by(name: "Everyone")
          @users = @everyone_group.users.search_by_first_name(params[:first_name]) if params[:first_name].present?
          @users = @everyone_group.users.search_by_last_name(params[:last_name]) if params[:last_name].present?
          @search_active = true
        else
          @users = []
          @search_active = false
        end
    end

    private

    def set_repertoire
      @repertoire = current_user.repertoire
      redirect_to(root_path, alert: "You are not authorized to access this directory.") unless @repertoire.id.to_s == params[:id]
    end
end
