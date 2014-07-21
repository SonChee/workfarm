class CreateChatGroups < ActiveRecord::Migration
  def change
    create_table :chat_groups do |t|
      t.string :name
      t.string :description
      t.string :note
      t.integer :farm_id
      t.timestamps
    end
  end
end
