class SessionsController < ApplicationController
	
	
  def new
  	@again=true
  	render :layout => 'blanco'  	
  end
  
  def create
	  	
  	if params[:mail]=='' || params[:password]=='' || params[:mail]==nil || params[:password]==nil
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
	 	if params[:holo] and !verify_recaptcha(:message => "Oh! Hay un error en el reCAPTCHA!")
		 	flash.now.alert = "Hay un error en el reCAPTCHA"
	 		render "new"
	 		return
	 	end
	 	
	  	if (user || id)
	  		if @next_time
	  			flash.now.alert = "Try again in "+@next_time.to_s+" minutes"
	  			render "new"
	  		elsif user
		  		session[:user_id] = user.id
	  			session[:session_token] = BCrypt::Engine.generate_salt
	  			user.session_token = session[:session_token]
	  			user.save!
	  			redirect_to home_path, :notice => "Te has conectado exitosamente!"
	  		else
	  			LoginFailure.create(:user_id => id)
	  			if @next_time 			
	  				text = "Try again in "+@next_time+" minutes"
				else	
					text = "Error en los datos entregados"
					if @entries
						times+=", ya has intentado de registar"+@entries.count+" veces" 
					end
	  			end
	  			flash.now.alert = text	
	  			render "new"
	  		end 		
	  	else
	  		flash.now.alert = "Error en los datos entregados"
	  		render "new"
	  	end
  	end
  end
  
  def destroy
  	session[:user_id] = nil
  	redirect_to  root_url, :notice => "Exitosamente desautenticado"
  end  
  
end
