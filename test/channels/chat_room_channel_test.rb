require "test_helper"

class ChatRoomTest < ActiveSupport::TestCase
  test "should save chat room with valid name" do
    chat_room = ChatRoom.new(name: 'General')
    assert chat_room.save
  end
end
