class RepertoiresController < ApplicationController
    before_action :authenticate_user!
    before_action :set_repertoire, only: [:show]

    def show
        @repertoire = current_user.repertoire

    end


    private

    def set_repertoire
      @repertoire = current_user.repertoire
      redirect_to(root_path, alert: "You are not authorized to access this directory.") unless @repertoire.id.to_s == params[:id]
    end
end
