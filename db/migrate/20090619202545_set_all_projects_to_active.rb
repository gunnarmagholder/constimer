class SetAllProjectsToActive < ActiveRecord::Migration
  def self.up
    Project.find(:all) do |project|
      project.active = true
      project.save
    end
  end

  def self.down
  end
end
