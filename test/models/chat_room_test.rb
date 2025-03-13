# test/models/message_test.rb
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "should not save message without content" do
    message = Message.new(user: "User")
    assert_not message.save, "Saved the message without content"
  end

  test "should save message with content" do
    message = Message.new(user: "User", content: "Hello!")
    assert message.save, "Couldn't save the message with content"
  end
end
