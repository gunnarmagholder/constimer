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
    @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
    @years = Entry.find(:all, :group => 'year(edate)')
#   if params[:project]
#     if params[:project][:id] != ""
#       @entries = Entry.find(:all, :conditions => ['user_id = ? and project_id = ?', current_user.id, params[:project][:id]], :order => ['edate ASC'], :include => :project)
#       @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
#     else
#       @entries = Entry.find(:all, :conditions => ['user_id = ? ', current_user.id], :order => ['project_id, edate ASC'], :include => :project)
#       @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
#     end
#   else
#     @entries = Entry.find(:all, :conditions => ['user_id = ? ', current_user.id], :order => ['project_id, edate ASC'], :include => :project)
#     @projects = Project.find(:all, :conditions => ['user_id = ?', current_user.id])
#   end
  end
  
  def show
  end
end
