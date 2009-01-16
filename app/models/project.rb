class Project < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  before_create :set_private
  
  def minutes
    Entry.sum(:minutes, :conditions => ['project_id = ?', self.id])
  end
  
  private
    def set_private
      self.private = 0 unless self.private == 1
    end
  
end
