class ApplicationController < ActionController::Base
  protect_from_forgery
   helper_method :current_user, :current_user_name, :authorize_post, :profesor?, :get_temas
   helper_method :admin, :admin?, :authorize, :update_time
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "No tienes los permisos adecuados"
  end
  #check_authorization
  private
  
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	#if session[:last_use] && session[:last_use] < (Time.now - 1.minutes)
  	#   endsession
  	#   redirect_to :root, :notice => "Session expired"
  	##else 
  	  ##	@current_user = nil
  	  ##	end_session
  	  ##	redirect_to login_path, :notice => 'Sin permisos'
  	 #end
  end
  
  def profesor?
	if current_user.type_id == 2
		true
	else
		false
	end
  end
  
  def current_user_name
  	@current_user_name ||= (@current_user && @current_user.username) ? @current_user.username : "stranger"
  end
  
  def authorize_post
  	if session[:session_token]
	  	@session_auth = session[:session_token]== @current_user.session_token ? true : false
	  	if @session_auth && session[:last_use] > 30.minute.ago
	  		end_session
	  	end
	  	@session_auth	
	else
		return false
	end  	
  end
  
  def end_session
  	watch_fake_attempt
  	session[:user_id]=nil
  	session[:session_token]=nil
  	session[:last_use]=nil
  end	
  
  def watch_fake_attempt
  	if session[:user_id] 
  		user=User.find(session[:user_id])
  		if session[:session_token]== user.session_token
  		  user.session_token = BCrypt::Engine.generate_salt
  		  user.save
  		end
  	end
  end	
  
  def admin
  	user = current_user
  	unless user && user.username && user.username.eql?("admin")
  		redirect_to :root, :notice => 'Unauthorized access'
  		false 
  	else
  		true
  	end
  end
  
  def admin?
  	user = current_user
  	if user && user.username && user.username.eql?("admin")
  		return true
  	else 
  		return false
  	end
  end
 
  def authorize
  	unless session[:user_id]
  		redirect_to :root, :notice => 'Unauthorized access'
  		false 
  	else
  		true
  	end
  end
   
  def update_time
  	session[:last_use]=Time.now
  end	
  
  def get_temas
  	@temas = Comment.scoped.where(:ancestry => nil, :oculto => false)
  end
  
end
