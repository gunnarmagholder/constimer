class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :manager
      t.integer :user
      t.integer :status
      t.timestamps
    end
  end
  
  def self.down
    drop_table :assignments
  end
end