class AddOcultoToComments < ActiveRecord::Migration
  def change
    add_column :comments, :oculto, :boolean
  end
end
