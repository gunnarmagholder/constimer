class Entry < ActiveRecord::Base
	TRY_FORMATS = ['%m/%d/%Y', '%d.%m.%Y','%Y-%m-%d']
	before_validation :cache_virtual_columns
	before_update :cache_virtual_columns
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
	
	def self.colleagues_time
	 if current_user.isRole('manager')
	   @colleagues = User.find(:all, :conditions => {:managed_by => current_user.id})
     Entry.find(:all, :conditions => {:user_id => @colleagues})
   end
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
  

  def edate
    self[:edate]
  end
  
  def edate=(date_entry)
    self[:edate] = try_to_parse(date_entry)
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
	  	  self.minutes = minutes_calculated	
  	  else
  	    self.minutes = 0
	    end
	  end
	  
	  
  	def try_to_parse(s)
  	  parsed = nil
  	  TRY_FORMATS.each do |format|
  	    begin
  	      parsed = Date.strptime(s, format)
  	      break
  	    rescue ArgumentError
  	    end
  	  end
  	  return parsed
  	end
	  
end
