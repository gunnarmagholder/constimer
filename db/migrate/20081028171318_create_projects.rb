class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.string :name
      t.string :custname
      t.float :budget
      t.timestamp :duedate

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
