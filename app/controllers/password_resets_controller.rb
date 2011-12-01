class PasswordResetsController < ApplicationController
  
	layout 'application'
	
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    
    redirect_to root_url, :notice => "Se ha enviado el mail con las instrucciones"
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    
    @cleaner = User.all
    @cleaner.each do |user|
	  if user.password_reset_sent_at && user.password_reset_sent_at < 2.hours.ago
	    user.password_reset_token = nil
	    user.save!
	  end
    end
    
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Contrase&ntilde;a ha expirado"      
 	end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Contrase&ntilde;a ha expirado."
    elsif @user.update_attributes(params[:user])
      @user.password_reset_token = nil
      @user.save
      redirect_to root_url, :notice => "Contrase&ntilde;a cambiada."
    else
      render :edit
    end
  end

end
