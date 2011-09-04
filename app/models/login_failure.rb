class LoginFailure < ActiveRecord::Base
	belongs_to :user

  def self.dont_aloud(id)
  	@entries = LoginFailure.where("user_id = ? AND created_at > ?", id, Time.now - 6.minutes)
  	if @entries && @entries.count > 2		
  		@next_time = ((Time.now - @entries[-2].created_at)/60).to_i
  	end
  end	
  
  def self.count_last_entries(id)
  	@entries = LoginFailure.where("user_id = ?",id )  	
  	if @entries && (@entries[-1].updated_at > 10.minutes)
  		@count = @entries.count 
  	end	
  	#falta agregar el campo count en la tabla..
  end	
  
  def self.add_entry
  	count_last_entries
  	if @count && @count > 2
  		@entries.count = @count + 1
  		@entries.save
  	end
  end
  
end
