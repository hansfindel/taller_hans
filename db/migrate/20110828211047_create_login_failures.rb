class CreateLoginFailures < ActiveRecord::Migration
  def change
    create_table :login_failures do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
