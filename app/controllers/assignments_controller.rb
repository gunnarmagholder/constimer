class AssignmentsController < ApplicationController
  before_filter :login_required 
  
  def index

    @assignments = Assignment.find(:all, :conditions => {:manager => current_user.id})
  end
  
  def show
    @assignment = Assignment.find(params[:id])
    @managername = User.find_by_id(current_user.id).name
    @status_name = @assignment.status_name
  end
  
  def new
    @assignment = Assignment.new
	@assignment.status = 1
    @assignment.manager = current_user.id
    @assignment.status = 1 
    @managername = User.find_by_id(current_user.id).name
    @status_name = @assignment.status_name
  end
  
  def create
    @assignment = Assignment.new(params[:assignment])
    @user = User.find_by_name(params[:assignment][:user])
    if @user and @user.id != current_user.id
      @assignment.user = @user.id  
      @assignment.manager = current_user.id
      @assignment.status = 1
      if @assignment.save
        flash[:notice] = "Successfully created assignment."
        redirect_to @assignment
      else
        render :action => 'new'
      end
    else
      flash[:error] = "User not found"
      render :action => 'new'
    end
  end
  
  def edit
    @assignment = Assignment.find(params[:id])
  end
  
  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      flash[:notice] = "Successfully updated assignment."
      redirect_to @assignment
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    flash[:notice] = "Successfully destroyed assignment."
    redirect_to assignments_url
  end
  
  def assign
    @asignment = Assignment.find(params[:id])
    @assignment.update_attribute :status, 4
    @user = User.find_by_id(@assignment.user)
    @user.update_attribute :managed_by, @assignment.manager
  end
  
end
