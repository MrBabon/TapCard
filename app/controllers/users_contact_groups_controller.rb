class UsersContactGroupsController < ApplicationController

    def update
        @users_contact_group = UsersContactGroup.find(params[:id])

        if @users_contact_group.update(users_contact_group_params)
            redirect_to some_path, notice: 'Note updated successfully.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def users_contact_group_params
    params.require(:users_contact_group).permit(:personal_note)
    end
end
