class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :kind
      t.string :short_description
      t.string :description
      t.integer :taskmaster_id
      t.integer :assignee_id
      t.string :status
      t.integer :process
      t.datetime :start_date
      t.datetime :due_date
      t.float :spent_time
      t.float :estimated_time
      t.integer :farm_id
      t.integer :project_id
      t.integer :target_version

      t.timestamps
    end
  end
end