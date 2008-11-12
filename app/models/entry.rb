class Entry < ActiveRecord::Base
	validates_presence_of :starttime, :on => :create, :message => "can't be blank"
	validates_presence_of :edate, :on => :create, :message => "can't be blank"
	validates_presence_of :user, :on => :create, :message => "can't be blank"
	validate :user_must_exist
	validate :endtime_must_be_after_starttime, :if => :endtime?
	
	belongs_to :user
	belongs_to :project
	def user_must_exist
	 errors.add(:user, 'should exist') if self.user.nil?
	end
	
  def endtime_must_be_after_starttime
    errors.add(:endtime, 'must not be before starttime') if starttime > endtime
  end
	
	def project_name
	  project.name if project
	end
	
	def project_name=(name)
	  logger.warn  '****Into project setter****'
	  self.project = Project.find_or_create_by_name_and_user_id(name, User.current_user.id) unless name.blank?
	end
end
