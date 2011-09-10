class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :curso
      t.integer :agno

      t.timestamps
    end
  end
end
