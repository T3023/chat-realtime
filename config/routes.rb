Rails.application.routes.draw do
  resources :chat_rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create] # Menambahkan nested route untuk pesan
  end

  post "chat_rooms/set_username", to: "chat_rooms#set_username"
end
