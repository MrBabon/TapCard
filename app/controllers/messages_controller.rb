class MessagesController < ApplicationController

    def create
        @chatroom = Chatroom.find(params[:chatroom_id])
        @message = Message.new(message_params)
        @message.chatroom = @chatroom
        @message.user = current_user
        if @message.save
            ChatroomChannel.broadcast_to(
                @chatroom,
                message: render_to_string(partial: "message", locals: {message: @message}),
                sender_id: @message.user.id,
                message_date: @message.created_at.to_date == Date.today ? "Today" : I18n.l(@message.created_at.to_date, format: :long)
            )
            head :ok
        else
          render "chatrooms/show", status: :unprocessable_entity
        end
    end

    private

    def message_params
    params.require(:message).permit(:content)
    end
end
