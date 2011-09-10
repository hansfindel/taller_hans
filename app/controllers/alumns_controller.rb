class AlumnsController < ApplicationController
	load_and_authorize_resource
  # GET /alumns
  # GET /alumns.json
  def index
    @alumns = Alumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @alumns }
    end
  end

  # GET /alumns/1
  # GET /alumns/1.json
  def show
    @alumn = Alumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @alumn }
    end
  end

  # GET /alumns/new
  # GET /alumns/new.json
  def new
    @alumn = Alumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @alumn }
    end
  end

  # GET /alumns/1/edit
  def edit
    @alumn = Alumn.find(params[:id])
  end

  # POST /alumns
  # POST /alumns.json
  def create
    @alumn = Alumn.new(params[:alumn])

    respond_to do |format|
      if @alumn.save
        format.html { redirect_to @alumn, :notice=> 'Alumn was successfully created.' }
        format.json { render :json=> @alumn, :status=> :created, :location=> @alumn }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @alumn.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # PUT /alumns/1
  # PUT /alumns/1.json
  def update
    @alumn = Alumn.find(params[:id])

    respond_to do |format|
      if @alumn.update_attributes(params[:alumn])
        format.html { redirect_to @alumn, :notice=> 'Alumn was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @alumn.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /alumns/1
  # DELETE /alumns/1.json
  def destroy
    @alumn = Alumn.find(params[:id])
    @alumn.destroy

    respond_to do |format|
      format.html { redirect_to alumns_url }
      format.json { head :ok }
    end
  end
end
