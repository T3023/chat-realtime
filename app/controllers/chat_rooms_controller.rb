class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
    @chat_room = @chat_rooms.first
    @messages = @chat_room.present? ? @chat_room.messages : [] # Pastikan @messages tidak nil
    @username = cookies[:username] # Ambil username dari cookies
  end

  def show
    @chat_room = ChatRoom.find_by(id: params[:id])

    if @chat_room.nil?
      redirect_to chat_rooms_path, alert: "Chatroom tidak ditemukan."
      return
    end

    @messages = @chat_room.messages
    @username = cookies[:username] # Ambil username dari cookies
  end

  def create
    if cookies[:username].blank?
      flash[:alert] = "Silakan masukkan nama Anda terlebih dahulu!"
      redirect_to chat_rooms_path and return
    end

    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      redirect_to chat_rooms_path, notice: "Chatroom berhasil dibuat!"
    else
      render :index
    end
  end

  def set_username
    cookies[:username] = params[:username] if params[:username].present?
    redirect_to chat_rooms_path
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
