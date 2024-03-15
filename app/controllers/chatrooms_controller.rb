class ChatroomsController < ApplicationController

    def show
        begin
            @chatroom = Chatroom.find(params[:id])
            @message = Message.new
        rescue ActiveRecord::RecordNotFound
            redirect_to chatrooms_path, alert: "La conversation a été supprimée ou n'existe pas."
        end
    end

    def index
        @chatrooms = current_user.chatrooms.joins(:messages).distinct
    end

    def create
        other_user = User.find(params[:other_user_id])
        chatroom = find_or_create_chatroom(current_user, other_user)
        redirect_to chatroom_path(chatroom)
    end

    def destroy
        @chatroom = Chatroom.find(params[:id])
        @chatroom.destroy
        ChatroomChannel.broadcast_to(
            @chatroom,
            { action: "chatroom_deleted" }
        )
        redirect_to chatrooms_path(current_user), notice: 'The group has been successfully deleted.'
    end

    private
  
    def find_or_create_chatroom(user1, user2)
        chatroom = Chatroom.find_by(user1: user1, user2: user2) || 
                Chatroom.find_by(user1: user2, user2: user1)

        unless chatroom
        chatroom = Chatroom.create(user1: user1, user2: user2)
        end

        chatroom
    end
end
