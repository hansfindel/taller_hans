class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :admin, :except => [:index, :new, :create, :show, :edit, :update]
  
   helper_method :sort_column, :sort_direction
  
   
# GET /users
  # GET /users.json
  def index
	if current_user && current_user.username.eql?("admin")
      @users = User.search(params[:search]).order(sort_column+" " + sort_direction).page(params[:page]).per(3)
      
    elsif current_user  
	  profe=User.find(session[:user_id])
	  lista_cursos = profe.courses
	  lista_alumnos = Array.new
	  lista_cursos.each do |l|
	  	list=l.alumns
	  	list.each do |x|
	  		lista_alumnos << x.user_id
  		end
      end
	  @users = User.find(lista_alumnos)	
	  
	else 
		redirect_to :root  
	end	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

	cursos = Alumn.where(:user_id => @user.id)
	ids = Array.new
	cursos.each do |curso|
		 ids << curso.course_id
	end
    
	@cursos = @user.courses + Course.find(ids)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new 
      
    respond_to do |format|
      format.html { render :layout => 'sin_log_in' }# new.html.erb 
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
 
  	session[:user_id] = @user.id
  	session[:last_use] = Time.now
  	session[:session_token] = BCrypt::Engine.generate_salt
  	@user.session_token = session[:session_token]

	if @user.username.eql?("admin")
	  @user.active=true	
	else
	  @user.active=false
	end 
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'Usuario creado.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
	
 	@user.active=true	if @user.username.eql?("admin")
    
 	respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'Actualizada.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  def sort_column
  	User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
  	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
