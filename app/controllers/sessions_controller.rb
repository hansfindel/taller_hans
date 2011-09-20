class SessionsController < ApplicationController
	
	
  def new
  	render :layout => false
  end
  
  def create
	  	
  	if params[:mail]=='' || params[:password]==''
  		flash.now.alert = "Falta informacion"
  		render "new"
  	else
  	
	  	if params[:mail].include?("@")
	  		user = User.authenticate_mail(params[:mail], params[:password])
	  	elsif params[:mail].to_i>0
	  		user = User.authenticate_rut(params[:mail], params[:password])
	  	else
	  		user = User.authenticate_name(params[:mail], params[:password])
	  	end
	  		
	  	id = User.get_id(params[:mail])
	 	var=LoginFailure.dont_aloud(id)
	 	if var
	 		if var.to_i>0
	 			@next_time=var
	 		else
	 			@entries=var
	 		end
	 	end
	  	if user || id
	  		if @next_time
	  			flash.now.alert = "Try again in "+@next_time.to_s+" minutes"
	  			render "new"
	  		elsif user
		  		session[:user_id] = user.id
	  			session[:session_token] = BCrypt::Engine.generate_salt
	  			user.session_token = session[:session_token]
	  			user.save!
	  			redirect_to home_path, :notice => "Logged in!"
	  		else
	  			LoginFailure.create(:user_id => id)
	  			if @next_time 			
	  				text = "Try again in "+@next_time+" minutes"
				else	
					text = "Invalid name/mail/rut or password"
					if @entries
						times+=" already tried "+@entries.count+" times" 
					end
	  			end
	  			flash.now.alert = text	
	  			render "new"
	  		end 		
	  	else
	  		flash.now.alert = "Invalid name/mail/rut or password"
	  		render "new"
	  	end
  	end
  end
  
  def destroy
  	session[:user_id] = nil
  	redirect_to  root_url, :notice => "logged out"
  end  
  
end
