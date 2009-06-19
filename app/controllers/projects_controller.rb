class ProjectsController < ApplicationController
  before_filter :login_required
  # GET /projects
  # GET /projects.xml
  def index
    # @projects = Project.find(:all, :conditions => ['(user_id = ? and name LIKE ?) or (user_id = ? and name LIKE ?) ', current_user.id, "%#{params[:q]}%", current_user.managed_by, "%#{params[:q]}%" ])
    respond_to do |format|
      format.html { @projects = Project.find(:all, :conditions => ['(user_id = ? and name LIKE ?) or (user_id = ? and name LIKE ?) ', current_user.id, "%#{params[:q]}%", current_user.managed_by, "%#{params[:q]}%" ]) }
      format.xml  { render :xml => @projects }
      format.js { @projects = Project.find(:all, :conditions => ['((user_id = ? and name LIKE ?) or (user_id = ? and name LIKE ? )) and active = true ', current_user.id, "%#{params[:q]}%", current_user.managed_by, "%#{params[:q]}%" ]);render :layout => false }
      format.json {render :layout => false, :json => @projects}
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @project.active = true
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.active = true
    @project.user = current_user
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    if Entry.find_by_project_id(params[:id]) == nil
      @project.destroy
      respond_to do |format|
        format.html { redirect_to(projects_url) }
        format.xml  { head :ok }
      end
    else
      flash[:error] = 'This project has active entries!'
      respond_to do |format|
        format.html { redirect_to(projects_url) }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
end
