class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:follow, :unfollow, :show]


    def index
        @users = User.where.not(id: current_user.id)
    end
    
    def show
        if @user == current_user
            redirect_to profil_user_path
        end
        if @user.entrepreneurs?
            @entreprise = @user.entreprises_as_owner.first
        elsif @user.employee_relationships?
            @employee = @user.entreprises_as_employee.first
        end
        @from_contact_group = session.delete(:from_contact_group)
    end
    
    def profil
        @user = current_user
        if current_user.director?
            @organization = current_user.organizations.first
        end
        if current_user.entrepreneurs?
            @entreprise = current_user.entreprises_as_owner.first
        end
        if current_user.employee_relationships?
            @employee = current_user.entreprises_as_employee.first
        end
    end

    def repertoire
        @repertoire = current_user.repertoire
        @contact_groups = @repertoire.contact_groups
        @contact_group = ContactGroup.new
        @groups = @repertoire.contact_groups.includes(:users)
        if params[:search].present?
          @everyone_group = @groups.find_by(name: "Everyone")
          search = "%#{params[:search]}%"
          @users = @everyone_group.users.where("first_name ILIKE ? OR last_name ILIKE ?", search, search)
          @search_active = true
        else
          @users = []
          @search_active = false
        end
        render 'repertoires/show'
    end

    def repertoire_user_profile
        @user = User.find(params[:id])
        @repertoire = current_user.repertoire
        @contact_groups = @repertoire.contact_groups
        @users_contact_group = current_user.repertoire.contact_groups
        .map(&:users_contact_groups)
        .flatten
        .find { |ucg| ucg.user_id == @user.id }
        user_in_repertoire = current_user.repertoire.contact_groups.any? do |group|
            group.users.exists?(@user.id)
        end
        if @user.entrepreneurs?
            @entreprise = @user.entreprises_as_owner.first
        elsif @user.employee_relationships?
            @employee = @user.entreprises_as_employee.first
        end
        unless user_in_repertoire
            redirect_to(root_path, alert: "Access denied because this user is not in your directory.")
            return
        end
    end
    
    def settings
        @user = current_user
    end

    def add_to_directory
        # Trouver l'utilisateur à ajouter
        user_to_add = User.find(params[:id])
        everyone_group = current_user.repertoire.contact_groups.find_by(name: 'Everyone')
        unless UsersContactGroup.exists?(user: user_to_add, contact_group: everyone_group)
            UsersContactGroup.create(user: user_to_add, contact_group: everyone_group)
        end    
        if everyone_group.save
            redirect_to user_path(user_to_add), notice: 'User was successfully added to the Everyone group.'
        else
            redirect_to user_path(user_to_add), alert: 'There was a problem adding the user to the Everyone group.'
        end
    end
    
    def follow
        if current_user.follow(@user.id)
            respond_to do |format|
            format.html { redirect_to profil_user_path }
            format.js
            end
        end
    end
    
    def unfollow
        if current_user.unfollow(@user.id)
            respond_to do |format|
            format.html { redirect_to profil_user_path }
            format.js { render action: :follow }
            end
        end
    end

    def my_events
        @user = current_user
        @participating_events = @user.events
        @participating_events = @participating_events.search_by_city(params[:city]) if params[:city].present?
        @participating_events = @participating_events.search_by_country(params[:country]) if params[:country].present?
        @participating_events = @participating_events.search_by_title(params[:title]) if params[:title].present?
        @participating_events = @participating_events.search_by_region(params[:region]) if params[:region].present?
        @visible_in_participants = {}
  
        # Boucle à travers les événements auxquels l'utilisateur participe pour obtenir la visibilité
        @participating_events.each do |event|
            participation = Participation.participation_for(@user, event)
            if participation
              @visible_in_participants[event.id] = participation.visible_in_participants
            else
              @visible_in_participants[event.id] = false  # Par défaut, l'utilisateur n'est pas visible s'il n'est pas inscrit
            end
        end
        @participation = Participation.find_by(user_id: @user.id)  # Assurez-vous que cela correspond à la logique de récupération de votre participation existante
    end

    def my_qr_code
        @user = current_user
        @qr_code = @user.qr_code
        # @svg = @qr_code.as_svg
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :avatar, :job, :biography, :industry, :website, :linkedin, :instagram, :facebook, :twitter, :qr_code)
    end

    def set_user
        @user = User.find(params[:id])
    end

end
