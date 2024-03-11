class ContactGroupsController < ApplicationController

  def show
    begin
      repertoire = current_user.repertoire
      @contact_group = repertoire.contact_groups.find(params[:id])
      if params[:search].present?
        search_term = "%#{params[:search]}%"
        @users = @contact_group.users.where("first_name ILIKE ? OR last_name ILIKE ?", search_term, search_term).order(:first_name)
      else
        @users = @contact_group.users.order(:first_name)
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_path, alert: "Access denied or Contact Group not found.")
    end
  end



end