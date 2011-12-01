class CoursesController < ApplicationController
	load_and_authorize_resource
	before_filter :authorize
  # GET /courses
  # GET /courses.json
  def index
  	if current_user && current_user.username.eql?("admin")
      @courses = Course.all
    elsif current_user
	  @lista = Profesor.joins(:course).where(:user_id => session[:user_id])	
	  list = Array.new
	  @lista.each do |l|
	  	list << l.course_id
      end
	  @courses = Course.find(list)
	end
		
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
	lista_profes = @course.profesors
	lista_alumnos = @course.alumns
	x = Array.new
	y = Array.new
	lista_profes.each do |p|
		x << p.user_id
	end
	lista_alumnos.each do |a|
		y << a.user_id
	end
	@profes = User.find(x)
	@alumnos = User.find(y)
	
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, :notice=> 'Curso creado' }
        format.json { render :json=> @course, :status=> :created, :location=> @course }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @course.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, :notice=> 'Curso actualizado' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @course.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :ok }
    end
  end
end
