class UsersController < ApplicationController
    before_action :authenticate_user!


    def show
        @user = User.find(params[:id])
        if @user == current_user
            redirect_to profil_user_path
        end
    end

    def settings
        @user = current_user
    end

    def profil
        @user = current_user
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

end
