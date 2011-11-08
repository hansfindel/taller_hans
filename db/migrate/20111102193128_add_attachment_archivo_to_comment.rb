class AddAttachmentArchivoToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :archivo_file_name, :string
    add_column :comments, :archivo_content_type, :string
    add_column :comments, :archivo_file_size, :integer
    add_column :comments, :archivo_updated_at, :datetime
  end

  def self.down
    remove_column :comments, :archivo_file_name
    remove_column :comments, :archivo_content_type
    remove_column :comments, :archivo_file_size
    remove_column :comments, :archivo_updated_at
  end
end
