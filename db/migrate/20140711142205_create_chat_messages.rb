class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.integer :user_id
      t.integer :chat_group_id
      t.string :message
      t.timestamps
    end
  end
end
