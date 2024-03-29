class ProfesorsController < ApplicationController
	load_and_authorize_resource
  # GET /profesors
  # GET /profesors.json
  def index
    @profesors = Profesor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @profesors }
    end
  end

  # GET /profesors/1
  # GET /profesors/1.json
  def show
    @profesor = Profesor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @profesor }
    end
  end

  # GET /profesors/new
  # GET /profesors/new.json
  def new
    @profesor = Profesor.new
    @profesors = User.where(:type_id => 2)
    @cursos = Course.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @profesor }
    end
  end

  # GET /profesors/1/edit
  def edit
    @profesor = Profesor.find(params[:id])
    @profesors = User.where(:type_id => 2)
    @cursos = Course.all
  end

  # POST /profesors
  # POST /profesors.json
  def create
    @profesor = Profesor.new(params[:profesor])
	
	uid = params[:profesor][:user_id]
	cid = params[:profesor][:course_id]
	@profesor.user_id = uid
	@profesor.course_id = cid
	
    respond_to do |format|
      if @profesor.save
        format.html { redirect_to @profesor, :notice=> 'Profesor creado' }
        format.json { render :json=> @profesor, :status=> :created, :location=> @profesor }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @profesor.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # PUT /profesors/1
  # PUT /profesors/1.json
  def update
    @profesor = Profesor.find(params[:id])
    
	uid = params[:profesor][:user_id]
	cid = params[:profesor][:course_id]
	@profesor.user_id = uid
	@profesor.course_id = cid
	
    respond_to do |format|
      if @profesor.update_attributes(params[:profesor])
        format.html { redirect_to @profesor, :notice=> 'Profesor actualizado.' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @profesor.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /profesors/1
  # DELETE /profesors/1.json
  def destroy
    @profesor = Profesor.find(params[:id])
    @profesor.destroy

    respond_to do |format|
      format.html { redirect_to profesors_url }
      format.json { head :ok }
    end
  end
end
