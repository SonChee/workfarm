class CreatePositionInFarms < ActiveRecord::Migration
  def change
    create_table :position_in_farms do |t|
      t.integer :user_id
      t.integer :farm_id
      t.integer :position
      t.integer :farm_request, null: false, default: 0
      t.integer :big_farm_id

      t.timestamps
    end
  end
end
