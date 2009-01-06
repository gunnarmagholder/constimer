class ReportController < ApplicationController
  def index
    @user = current_user
    conditions = ['user_id = ?', current_user.id]
    if params[:project]
      if params[:project][:id] != ""
        conditions[0] = conditions[0] + " and project_id = ? "
        conditions = conditions + [params[:project][:id]]
      end
    end
    if params[:date]
      if params[:date][:month] != ""
        conditions[0] = conditions[0] + " and MONTH(edate) = ? "
        conditions = conditions + [params[:date][:month]]      
      end
      if params[:date][:year] != ""
        conditions[0] = conditions[0] + " and YEAR(edate) = ? "
        conditions = conditions + [params[:date][:year]]      
      end
    end
    @entries = Entry.find(:all, :conditions => conditions)
    @overall_min = @entries.sum(&:minutes)
    if current_user.isRole('manager') 
	  	
    else
      @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    end
    @years = Entry.find(:all, :group => 'year(edate)',:conditions => ['user_id = ?', current_user.id])
  end
  
  def show
  end
end
