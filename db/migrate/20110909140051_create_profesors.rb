class CreateProfesors < ActiveRecord::Migration
  def change
    create_table :profesors do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
