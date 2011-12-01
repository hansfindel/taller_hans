class AddOcultoToComments < ActiveRecord::Migration
  def change
    add_column :comments, :oculto, :boolean
    
    Comment.all.each do |c|
    	c.oculto=false
    	c.save
    end
    
  end
end
