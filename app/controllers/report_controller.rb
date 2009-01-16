class ReportController < ApplicationController
  def index
    @user = current_user
    if current_user.isRole('manager')
      @colleagues = User.find(:all, :conditions => {:managed_by => current_user.id})
      conditions = ['`projects`.`private` <> true AND `entries`.`user_id` in (?) ', @colleagues]
    else
      conditions = ['`entries`.`user_id` = ?', current_user.id]
    end
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
    
    @entries = Entry.find(:all, :include => :project, :conditions => conditions)
    @overall_min = @entries.sum(&:minutes)
    if current_user.isRole('manager') 
	  	@projects = Project.find(:all, :conditions => ['(user_id = ? OR user_id in (?)) AND private = 0', current_user.id, @colleagues])
    else
      @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    end
    @years = Entry.find(:all, :group => 'year(edate)',:conditions => ['`entries`.`user_id` = ?', current_user.id])
  end
  
  def show
  end
end
