class ReportController < ApplicationController
  def index
    @user = current_user
    if params[:project][:id] != ""
      @entries = Entry.find(:all, :conditions => ['user_id = ? and project_id = ?', current_user.id, params[:project][:id]], :order => ['edate ASC'], :include => :project)
      @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    else
      @entries = Entry.find(:all, :conditions => ['user_id = ? ', current_user.id], :order => ['project_id, edate ASC'], :include => :project)
      @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    end
  end
  
  def show
    @user = current_user
    if params[:month].to_i > 200801 and params[:month].to_i < 202012
      @pdate = params[:month].to_s
      @pyear = @pdate[0..3]
      @pmonth = @pdate[4..5]
      logger.info '============> Found a date ' + @pyear + '/' + @pmonth + '<==================='
    else
      flash[:notice] = "parameters don't make sense"
      redirect_to :action => "index"
    end
    @project = Project.find(:all, :conditions => ['user_id = ? and id = ? ', current_user.id, "#{params[:project]}" ])
    if @project.first
      @project_id = params[:project]
      logger.info '============> Found a project ' + @project.first.name.to_s + ' with id ' + @project.id.to_s + '<==================='
    else
       flash[:notice] = "parameters don't make sense"
       redirect_to :action => "index"
    end  
   
    @entries = Entry.find(:all, :conditions => ['user_id = ? AND month(edate) = ? and year(edate) = ? and project_id = ?', current_user.id,@pmonth, @pyear, @project_id], :order => ['edate ASC'], :include => :project)
  end
 
end
