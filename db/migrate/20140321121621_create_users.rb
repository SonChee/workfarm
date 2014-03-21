class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :code
      t.string :name
      t.string :password_digest
      t.string :email

      t.timestamps
    end
    add_index :users, [:email], unique: true
    add_index :users, [:code], unique: true
  end
end
