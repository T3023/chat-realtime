import React, { useState, useEffect } from 'react';
import Cable from 'actioncable';

const ChatRoom = ({ chatRoomId }) => {
  const [messages, setMessages] = useState([]);
  const [messageContent, setMessageContent] = useState('');
  const [user, setUser] = useState('');

  useEffect(() => {
    const cable = Cable.createConsumer('ws://localhost:3000/cable');
    const channel = cable.subscriptions.create(
      { channel: 'ChatRoomChannel', chat_room_id: chatRoomId },
      {
        received: data => {
          setMessages(prevMessages => [...prevMessages, data.message]);
        }
      }
    );

    return () => {
      channel.unsubscribe();
    };
  }, [chatRoomId]);

  const sendMessage = () => {
    if (messageContent) {
      fetch(`/chat_rooms/${chatRoomId}/messages`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          user: user,
          content: messageContent,
          chat_room_id: chatRoomId,
        }),
      });

      setMessageContent('');
    }
  };

  return (
    <div>
      <div>
        {messages.map((message, index) => (
          <div key={index}>
            <strong>{message.user}:</strong> {message.content}
          </div>
        ))}
      </div>
      <input
        type="text"
        placeholder="Your name"
        value={user}
        onChange={e => setUser(e.target.value)}
      />
      <textarea
        value={messageContent}
        onChange={e => setMessageContent(e.target.value)}
      />
      <button onClick={sendMessage}>Send</button>
    </div>
  );
};

export default ChatRoom;
