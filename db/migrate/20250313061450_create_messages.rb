class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :user
      t.text :content
      t.references :chat_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
