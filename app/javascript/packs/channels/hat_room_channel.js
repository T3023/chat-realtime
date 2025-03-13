import consumer from "./consumer"

const chatRoomChannel = (chatRoomId) => {
  return consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: chatRoomId }, {
    connected() {
      console.log("Connected to chat room " + chatRoomId);
    },

    disconnected() {
      console.log("Disconnected from chat room " + chatRoomId);
    },

    received(data) {
      const messageContainer = document.getElementById("messages");
      const messageElement = document.createElement("p");
      messageElement.innerHTML = `<strong>${data.user}:</strong> ${data.message}`;
      messageContainer.appendChild(messageElement);

      messageContainer.scrollTop = messageContainer.scrollHeight;
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  const chatRoomId = document.getElementById("chat-room-id").value;
  const chatChannel = chatRoomChannel(chatRoomId);

  document.getElementById("message-form").addEventListener("submit", (event) => {
    event.preventDefault();

    const username = document.getElementById("username").value;
    const messageInput = document.getElementById("message-content");

    if (username.trim() === "" || messageInput.value.trim() === "") {
      alert("Nama dan pesan tidak boleh kosong!");
      return;
    }

    chatChannel.send({ user: username, message: messageInput.value });

    messageInput.value = "";
  });
});

export default chatRoomChannel;
