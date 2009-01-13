class ReportController < ApplicationController
  def index
    @user = current_user
    conditions = {:user_id => current_user.id}
    if params[:project]
      if params[:project][:id] != ""
        conditions.update({:project_id => params[:project][:id]})
      end
    end
    if params[:date]
      if params[:date][:month] != ""
        conditions.update({:edate.month => [params[:date][:month]]})
      end
      if params[:date][:year] != ""
        conditions.update({:edate.year => [params[:date][:year]]})
      end
    end
    @entries = Entry.find(:all, :conditions => conditions)
    @overall_min = @entries.sum(&:minutes)
    if current_user.isRole('manager') 
	  	@projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    else
      @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    end
    @years = Entry.find(:all, :group => 'year(edate)',:conditions => ['user_id = ?', current_user.id])
  end
  
  def show
  end
end
