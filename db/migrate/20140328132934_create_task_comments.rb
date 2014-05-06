class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end