class CreateFlagReads < ActiveRecord::Migration
  def change
    create_table :flag_reads do |t|
      t.integer :user_id
      t.integer :chat_message_id
      t.integer :chat_group_id
      t.integer :flag, default: 0
      t.timestamps
    end
  end
end
