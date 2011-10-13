class AddAncestryToComment < ActiveRecord::Migration
  def change
    add_column :comments, :ancestry, :string
    add_index :comments, :ancestry
  end
  def self.down
    remove_index :messages, :ancestry
    remove_column :messages, :ancestry
  end
end
