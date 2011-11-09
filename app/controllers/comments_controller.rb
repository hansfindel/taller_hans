class CommentsController < ApplicationController
 load_and_authorize_resource
  # GET /comments
  # GET /comments.json

  def index
    @comments = Comment.scoped
    @comment = Comment.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
	
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new(:parent_id => params[:parent_id])

    if params[:parent_id]
		@padre = Comment.find(params[:parent_id]) 
    else
    	if !profesor?	
    		redirect_to home_url
    	else
    		respond_to do |format|
      		  format.html # new.html.erb
      		  format.json { render :json=> @comment }
    		end
    	end
    end    
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
	@comment.user_id = session[:user_id]
	if !@comment.calification
		@comment.calification = 1
	end
	@comment.oculto = false
	
    respond_to do |format|
      if @comment.save
      	if @comment.parent
      		@comment.parent.mi_nota
      		@comment.parent.save 
  	    end  	    
        format.html { redirect_to comments_path, :notice=> 'Comentario creado.' }
        format.json { render :json=> @comment, :status=> :created, :location=> @comment }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @comment.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
	if !@comment.calification
		@comment.calification = 1
	end
	
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
      	if @comment.parent
      		@comment.parent.mi_nota
      		@comment.parent.save 
  	    end
        format.html { redirect_to @comment, :notice=> 'Commentario actualizado' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @comment.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
     @comment = Comment.find(params[:id])
	if @comment.is_root?
		@comment.destroy
		redirect_to comments_path
		return
	end
	@destino = @comment.root
	@padre = @comment.parent
	@padre.mi_nota
	@comment.destruir

    respond_to do |format|
      format.html { redirect_to @destino }
      format.json { head :ok }
    end
  end
 
   def ocultar
     @comment = Comment.find(params[:id])
	 @comment.oculto = true
	 @destino = @comment.root

    respond_to do |format|
      format.html { redirect_to @destino }
      format.json { head :ok }
    end
  end
  
 
end
