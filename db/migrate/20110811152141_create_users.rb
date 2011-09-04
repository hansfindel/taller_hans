class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :rut
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :email
      t.integer :type_id

      t.timestamps
    end
  end
end
