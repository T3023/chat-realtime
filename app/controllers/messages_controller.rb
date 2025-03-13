class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(message_params)
    @message.user = cookies[:username] # Menggunakan nama dari cookies

    if @message.save
      redirect_to chat_room_path(@chat_room), notice: "Pesan terkirim!"
    else
      redirect_to chat_room_path(@chat_room), alert: "Gagal mengirim pesan."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
