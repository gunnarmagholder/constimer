class ReportController < ApplicationController
  def index
    @user = current_user
    @entries = Entry.find(:all, :conditions => ['user_id = ? ', current_user.id ], :order => ['project_id, edate ASC'])
  end
end
