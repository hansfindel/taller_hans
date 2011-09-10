class HomeController < ApplicationController
	layout 'application'
	before_filter :authorize, :except => [:index]
	before_filter :current_user
	before_filter :update_time
  def index
  	
  end

  def home
  	#@time = Time.now
  	#@time2 = session[:last_use]
  	
  end

end
