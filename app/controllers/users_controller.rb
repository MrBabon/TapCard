class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user
    end

    def settings
        @user = current_user
    end

    def my_events
        @user = current_user
        @participating_events = @user.events
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :avatar, :job, :biography, :industry, :website, :linkedin, :instagram, :facebook, :twitter)
    end

end
