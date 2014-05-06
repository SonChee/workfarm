class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :email
      t.datetime :birthday
      t.integer :city_id
      t.integer :home_town_id
      t.string :address
      t.integer :university_id
      t.integer :class_id
      t.integer :current_big_farm_id
      t.timestamps
    end
    add_index :users, [:email], unique: true
    add_index :users, [:code], unique: true
  end
end
