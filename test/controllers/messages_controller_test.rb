# test/controllers/messages_controller_test.rb
require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should create message" do
    chat_room = chat_rooms(:one)  # assuming you have a fixture for chat rooms
    post chat_room_messages_url(chat_room), params: { message: { user: "User", content: "Test message" } }
    assert_response :success
  end
end
