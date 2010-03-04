class Project < ActiveRecord::Base
  belongs_to :user
  has_many :entries
  before_create :set_defaults
  
  def minutes
    Entry.sum(:minutes, :conditions => ['project_id = ?', self.id])
  end

  def guest_url
    return "http://" + HOST + "/projects/" + self.id.to_s + "/guest/" + self.uuid.to_s
  end
  
  private
    def set_defaults
      self.private = 0 unless self.private == 1
      self.active = 1 unless self.private == 0
    end
  
end
