class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.float :my_grade
      t.float :calification

      t.timestamps
    end
  end
end
