class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :parent_farm_id
      t.integer :kind
      t.integer :floor

      t.timestamps
    end
  end
end