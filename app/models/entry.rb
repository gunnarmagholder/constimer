class Entry < ActiveRecord::Base
	before_validation :cache_virtual_columns
	validates_presence_of :starttime, :on => :create, :message => "can't be blank"
	validates_presence_of :edate, :on => :create, :message => "can't be blank"
	validates_presence_of :user, :on => :create, :message => "can't be blank"
	validates_presence_of :project_id, :on => :create, :message => "must be a valid project"
	validate :user_must_exist
	validate :endtime_must_be_after_starttime, :if => :endtime?
	
	belongs_to :user
	belongs_to :project
	
	def user_must_exist
	 errors.add(:user, 'should exist') if self.user.nil?
	end
	
	def minutes_calculated
	 if endtime? 
	   ((endtime - starttime) / 60).round
	 else
     0
   end
	end
	
  def endtime_must_be_after_starttime
    errors.add(:endtime, 'must not be before starttime') if starttime > endtime
  end
	
	def project_name
	  project.name if project
	end
	
	def project_name=(name)
	  logger.warn  '****Into project setter****'
	  # Geht so nicht. Hier muss die Abfrage rein, ob das Projekt beim User ODER beim manager existiert
	  if Project.find_by_name_and_user_id(name, User.current_user.managed_by)
	    self.project = Project.find_by_name_and_user_id(name, User.current_user.managed_by)
    else
	    self.project = Project.find_or_create_by_name_and_user_id(name, User.current_user.id) unless name.blank?
    end
	end
	private
	  def cache_virtual_columns
	    if endtime
	  	  self.minutes = ((endtime - starttime) / 60).round	    	
	    end
	  end
end
