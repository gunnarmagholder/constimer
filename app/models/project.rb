class Project < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  
  def minutes
    Entry.sum(:minutes, :conditions => ['project_id = ?', self.id])
  end
  
end
