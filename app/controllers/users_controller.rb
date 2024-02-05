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
    end
    
    def profil
        @user = current_user
    end
    
    def settings
        @user = current_user
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
